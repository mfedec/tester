require 'spec_helper'
require 'support/docker_helper'
require 'tester'

RSpec.describe 'Integration Tests' do
  before(:all) do
    # TODO: (maybe), check to see if docker containers running? If so, destroy them
    DockerHelper.start
    DockerHelper.wait_for_healthy
    DockerHelper.setup_syncer
  end

  after(:all) do
    DockerHelper.stop unless ENV['KEEP_ALIVE']
  end

  before(:each) do
    DockerHelper.setup_source
    DockerHelper.setup_syncer
  end

  after(:each) do
    DockerHelper.reset_source
  end

  describe 'tester' do
    it 'syncs the directory' do
      # There are better ways to check for existence of files, this is just a simple
      # example to interact with the docker containers.

      # Run the sync command
      DockerHelper.run_tester
      # Make sure new directory exists
      expect(DockerHelper.run_check('/app')).to eq('1')

      # Make sure directory has some files
      expect(DockerHelper.run_check('/app/tester1')).to eq('2')
    end
  end
end
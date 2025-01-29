require 'spec_helper'
require 'support/docker_helper'
require 'tester'

RSpec.describe 'Integration Tests' do
  before(:all) do
    # TODO: (maybe), check to see if docker containers running? If so, destroy them
    DockerHelper.start
    # Current setup tells me this doesn't wait for each container to be ready
    # once one returns ready it will move on?

    # DockerHelper.wait_for_healthy
    DockerHelper.wait_for_ssh_server
    DockerHelper.setup_syncer
  end

  after(:all) do
    DockerHelper.stop unless ENV['KEEP_ALIVE']
  end

  before(:each) do
    DockerHelper.setup_source
  end

  after(:each) do
    DockerHelper.reset_source
  end

  describe 'tester' do
    it 'syncs the directory' do
      # DockerHelper.tester
    end
  end
end
require 'thor'
require 'tester'

module Tester
  class CLI < Thor

    desc 'sync', 'Basic sync support for transferring individual files'
    def sync
      Tester::Test.sync 'super_awesome.txt', '192.168.1.1', '192.168.1.2'
    end
  end
end
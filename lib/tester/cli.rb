require 'thor'
require 'tester'

module Tester
  class CLI < Thor

    desc 'sync', 'Basic sync support for transferring individual files'
    def sync(src, dest)
      Tester::Test.sync src, dest
    end
  end
end
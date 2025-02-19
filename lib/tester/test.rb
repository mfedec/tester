module Tester
  class Test
    def self.sync(src, dest)
      puts "syncing #{src} to #{dest}"
      system("scp -r #{src} #{dest}")
    end
  end
end

require 'socket'
require 'open3'

module DockerHelper

  class << self
    def start
      compose_command('up --build -d')
    end

    def stop
      compose_command('down')
    end

    def wait_for_healthy(timeout: 30)
      timeout_at = Time.now + timeout
      while compose_command("ps -a | tail -n +2 | grep -v '(healthy)' | wc -l", capture: true).strip != '0'
        if timeout_at < Time.now
          compose_command("ps -a | tail -n +2 | grep -v '(healthy)'")
          raise "Container not healthy after #{timeout} seconds" if timeout_at < Time.now
        end
        sleep 0.1
      end
    end

    def setup_source
      compose_command('exec --workdir /provision source ./setup.sh')
    end

    def reset_source
      compose_command('exec --workdir /provision source ./reset.sh')
    end

    def setup_syncer
      compose_command('exec --workdir /provision syncer ./setup.sh')
    end

    def reset_syncer
      compose_command('exec --workdir /provision syncer ./reset.sh')
    end

    def run_tester
      compose_command('exec syncer tester sync root@source:/app/tester1/ /app/')
    end

    def run_check(directory)
      compose_command("exec syncer ls #{directory} | wc -l", capture: true).strip
    end

    private

      def compose_command(command, echo: true, capture: false)
        puts "[docker compose] #{command}" if echo
        stdout_str = ''
        stderr_str = ''

        Open3.popen3("cd spec/integration && docker compose #{command}") do |_, stdout, stderr, wait_thr|
          stdout_thread = Thread.new do
            stdout.each_line do |line|
              puts line
              stdout_str << line if capture
            end
          end

          stderr_thread = Thread.new do
            stderr.each_line do |line|
              warn line
              stderr_str << line if capture
            end
          end

          stdout_thread.join
          stderr_thread.join

          exit_status = wait_thr.value
          raise stderr_str unless exit_status.success?
        end

        capture ? stdout_str : true
      end
  end
end

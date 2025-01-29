require 'socket'

module DockerHelper
  SOURCE_SSH_SERVER_PORT = 2122

  class << self
    def start
      compose_command('up --build -d')
    end

    def stop
      compose_command('down')
    end

    # This doens't work, we need to capture the stdout so we can the integer value.
    # Right now this always returns true and is in an endless loop.
    # def wait_for_healthy(timeout: 30)
    #   timeout_at = Time.now + timeout
    #   while compose_command("ps -a | tail -n +2 | grep -v '(healthy)' | wc -l") != 0
    #     if timeout_at < Time.now
    #       compose_command("ps -a | tail -n +2 | grep -v '(healthy)'")
    #       raise "Container not healthy after #{timeout} seconds" if timeout_at < Time.now
    #     end
    #     sleep 0.1
    #   end
    # end

    def wait_for_ssh_server(retries: 3)
      Socket.tcp('localhost', SOURCE_SSH_SERVER_PORT, connect_timeout: 1).close
      sleep(1)
    rescue Errno::ECONNREFUSED, Errno::ETIMEDOUT
      retries -= 1
      sleep(2) && retry if retries.positive?
      raise 'SSH server did not start within container'
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

    # This runs the command to execute the tester gem.
    def tester
      compose_command("exec --workdir /app/app1 syncer tester")
    end

    private

      def compose_command(command, echo: true)
        puts "[docker compose] #{command}" if echo
        succeeded = system("cd spec/integration && docker compose #{command}")

        raise "Command `#{command}` failed with error code `#{$?}`" if !succeeded

        succeeded
      end
  end
end

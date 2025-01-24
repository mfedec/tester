module DockerHelper
  SOURCE_SSH_SERVER_PORT = 2122
  TESTER_SSH_SERVER_PORT = 2123

  class << self
    def start
      compose_command('up --build -d')
    end

    def stop
      compose_command('down')
    end

    def wait_for_ssh_server(retries: 3)
      Socket.tcp('localhost', SSH_SERVER_PORT, connect_timeout: 1).close
      sleep(1)
    rescue Errno::ECONNREFUSED, Errno::ETIMEDOUT
      retries -= 1
      sleep(2) && retry if retries.positive?
      raise 'SSH server did not start within container'
    end

    def setup_syncer
      compose_command('exec --workdir /provision syncer ./syncer_setup.sh')
    end

    def setup_source
      compose_command('exec --workdir /provision source ./source_setup.sh')
    end

    def reset_source
      compose_command('exec --workdir /provision source ./source_reset.sh')
    end

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

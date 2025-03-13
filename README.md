# Tester

This repo is just a basic example / template of how to setup integration testing for your CLI apps that interact with servers.

For the example, we will be writing and testing a basic cli that syncs a file between 2 servers.

The focus for this repo is not about the cli, but instead how to setup integration tests that spins up docker containers that we will use to test the actual functionality of the CLI.

## Idea
Have you ever needed to test an application that interacts with multiple servers, but setting up and tearing down real infrastructure was too slow or complicated? 

This repo contains the basic setup/framework that sets up ephemeral Linux servers where we can execute commands over SSH and verify expected behaviours.

Even if you use a different testing framework or want to test a different CLI or script, this approach can be easily adapted to your stack.

## Usage

- Update `setup.sh` in `spec/integration/docker/source` and `spec/integration/docker/source` to include any applications, files, directories, anything you need to configured before the test suite runs
- Update `reset.sh` in `spec/integration/docker/source` and `spec/integration/docker/source` to reset the servers to a state before the test suite ran
- `bundle exec rspec`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mfedec/tester.

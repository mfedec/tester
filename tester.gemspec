# frozen_string_literal: true

require_relative "lib/tester/version"

Gem::Specification.new do |spec|
  spec.name = "tester"
  spec.version = Tester::VERSION
  spec.authors = ["Martin Fedec"]
  spec.email = ["martin.fedec@gmail.com"]

  spec.summary = "Basic setup for integration testing a cli app"
  spec.description = "Basic setup for integration testing a cli app"
  spec.homepage = "https://github.com/mfedec/tester"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/mfedec/tester"
  spec.metadata["changelog_uri"] = "https://github.com/mfedec/tester/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  # gemspec = File.basename(__FILE__)
  # spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
  #   ls.readlines("\x0", chomp: true).reject do |f|
  #     (f == gemspec) ||
  #       f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
  #   end
  # end

  spec.files = Dir.glob('{lib,bin}/**/*')
  spec.executables = ['tester']

  spec.require_paths = ["lib"]

  spec.add_dependency "thor"

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "open3", "~> 0.1"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end

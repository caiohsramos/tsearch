require_relative 'lib/tsearch/version'

Gem::Specification.new do |spec|
  spec.name          = "tsearch-cli"
  spec.license       = "MIT"
  spec.version       = Tsearch::VERSION
  spec.authors       = ["Caio Ramos"]
  spec.email         = ["caioramos97@gmail.com"]

  spec.summary       = 'Ruby CLI for RARBG torrent search'

  spec.homepage      = "https://github.com/caiohsramos/tsearch"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/caiohsramos/tsearch"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rake", "~> 12.0"
  spec.add_dependency "rarbg", "~> 2.0"
  spec.add_dependency "activesupport", "~> 6.1"

  spec.add_development_dependency "solargraph", "~> 0.40.2"
  spec.add_development_dependency "rubocop", "~> 1.9"
  spec.add_development_dependency "byebug", "~> 11.1" 
end

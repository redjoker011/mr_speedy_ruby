# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mr_speedy_ruby/version"

Gem::Specification.new do |spec|
  spec.name          = "mr_speedy_ruby"
  spec.version       = MrSpeedyRuby::VERSION
  spec.authors       = ["Peter John Alvarado"]
  spec.email         = ["peterjohn@gorated.ph"]

  spec.summary       = "Mr.speedy api integration for ruby"
  spec.description   = "Provides services for integrating mr.speedy in your app"
  spec.homepage      = "https://mrspeedy.ph"
  spec.license       = "MIT"
  spec.extra_rdoc_files = Dir["README.md", "CHANGELOG.md", "LICENSE.txt"]
  spec.rdoc_options += [
    "--title", "MrSpeedyRuby - mr.speedy api integration for ruby",
    "--main", "README.md",
    "--line-numbers",
    "--inline-source",
    "--quiet"
  ]

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "vcr", "~> 5.1.0"
  spec.add_development_dependency "webmock", "~> 3.8.3"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "awesome_print"
end

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "magazine/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "magazine"
  s.version     = Magazine::VERSION
  s.authors     = ["kozo yamagata"]
  s.email       = ["tune002@gmail.com"]
  s.homepage    = "https://github.com/halenohi/magazine"
  s.summary     = "Static file article system for Rails"
  s.description = "Magazine is static file article system for Rails"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.1", "> 4.1"
  s.add_dependency "hashie", "~> 3.3", ">= 3.3.2"

  s.add_development_dependency "rspec-rails", "~> 3.1", ">= 3.1.0"
  s.add_development_dependency "capybara", "~> 2.4", ">= 2.4.4"
  s.add_development_dependency "tapp", "~> 1.4", ">= 1.4.1"
  s.add_development_dependency "sqlite3", "~> 1.3", ">= 1.3.10"
  s.add_development_dependency "delorean", "~> 2.1", ">= 2.1.0"
end

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
  s.description = "Static file article system for Rails"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.8"
  s.add_dependency "hashie"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "tapp"
  s.add_development_dependency "sqlite3"
end

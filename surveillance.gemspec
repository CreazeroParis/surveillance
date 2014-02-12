$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "surveillance/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "surveillance"
  s.version     = Surveillance::VERSION
  s.authors     = ["Valentin Ballestrino"]
  s.email       = ["vala@glyph.fr"]
  s.homepage    = "http://www.glyph.fr"
  s.summary     = "Dynamic poll creation Rails engine"
  s.description = "Allows you to give your users the ability to create polls in your Rails app"

  s.files = Dir["{app,config,db,lib,spec}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 3.2"
  s.add_dependency "decent_exposure", "~> 2.0"
  s.add_dependency "haml", ">= 3.0"
  s.add_dependency "haml-rails"
  s.add_dependency "coffee-rails", ">= 3.0.0"
  s.add_dependency "jquery-rails", ">= 2.0"
  s.add_dependency "sass-rails", ">= 3.0"
  s.add_dependency "simple_form"
  s.add_dependency "state_machine"
  s.add_dependency "spreadsheet_on_rails"

  s.add_development_dependency "sqlite3"

  s.add_development_dependency "rspec-rails", "~> 3.0.0.beta"
  s.add_development_dependency "factory_girl_rails", "~> 4.0"
  s.add_development_dependency "shoulda-matchers"
  s.add_development_dependency "database_cleaner"

  # s.add_development_dependency "launchy"
  # s.add_development_dependency "selenium-webdriver"

  # s.add_development_dependency "capybara"

  s.add_development_dependency "spork", "~> 1.0rc"
  s.add_development_dependency "guard-spork"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "terminal-notifier-guard"

  s.add_development_dependency "simplecov"
end

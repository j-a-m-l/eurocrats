$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "eurocrat/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "eurocrat"
  s.version     = Eurocrat::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Eurocrat."
  s.description = "TODO: Description of Eurocrat."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails', '~> 4.2.0'
  s.add_dependency 'jbuilder'
  s.add_dependency 'countries'
  s.add_dependency 'valvat'
  s.add_development_dependency 'sqlite3'

end

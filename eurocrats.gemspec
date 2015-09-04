$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "eurocrats/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "eurocrats"
  s.version     = Eurocrats::VERSION
  s.authors     = ['Juan A. Martín Lucas']
  s.email       = 'eurocrats@jaml.site'
  s.homepage    = 'http://github.com/j-a-m-l/eurocrats'
  s.summary     = "TODO: Summary of eurocrats."
  s.description = "TODO: Description of eurocrats."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails', '~> 4.2.0'
  s.add_dependency 'jbuilder'
  s.add_dependency 'countries'
  s.add_dependency 'valvat'
  s.add_development_dependency 'sqlite3'

end

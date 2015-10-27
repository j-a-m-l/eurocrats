# -*- encoding: utf-8 -*-
require_relative './lib/eurocrats/version'

Gem::Specification.new do |s|
  s.name        = "eurocrats"
  s.version     = Eurocrats::VERSION
  s.summary     = 'Library / Rails engine for dealing with European VAT'
  s.description = 'Library / Rails engine for dealing with European VAT'
  s.license     = "MIT"
  s.authors     = ['Juan A. Martín Lucas']
  s.email       = 'eurocrats@jaml.site'
  s.homepage    = 'http://github.com/j-a-m-l/eurocrats'

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]
  s.require_paths = ['lib']

  # 
  s.add_dependency 'countries'
  s.add_dependency 'valvat'

  s.add_dependency 'money'
  s.add_dependency 'eu_central_bank'

  # Rails only
  s.add_dependency 'rails', '~> 4.2.0'
  s.add_dependency 'jbuilder'

  s.add_development_dependency 'sqlite3'

end

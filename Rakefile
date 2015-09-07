begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.title    = 'Eurocrats'
  rdoc.main = 'README.md'
  rdoc.rdoc_files.include('README.md')
  rdoc.rdoc_files.include('lib/**/*.rb')
  rdoc.options << '--line-numbers'
end


APP_RAKEFILE = File.expand_path("../spec/dummy/Rakefile", __FILE__)
load 'rails/tasks/engine.rake'


# Bundler::GemHelper.install_tasks
# 
# require 'rake/testtask'
# 
# Rake::TestTask.new(:test) do |t|
#   t.libs << 'lib'
#   t.libs << 'spec'
#   t.pattern = 'spec/**/*_test.rb'
#   t.verbose = false
# end
# 
# 
# task default: :test

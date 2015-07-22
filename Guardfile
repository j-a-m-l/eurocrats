guard :bundler do
  watch 'Gemfile'
end

guard :rspec, cmd: 'rspec --format progress --color -r ./spec/spec_helper.rb', all_on_start: true, all_after_pass: false do

  watch 'spec/spec_helper.rb'
  watch(%r{^spec/factories/(.+)_factory\.rb$}) { |m| "spec/models/#{m[1]}_spec.rb" }
  watch('spec/support/controller_helpers.rb')          { |m| "spec/controllers" }
  watch %r{^spec/support/.+\.rb$}

  watch(%r{^spec/.+_spec\.rb$})

  watch('config/routes.rb') { 'spec/routing' }

  watch(%r{^app/(.+)/eurocrat/(.+)\.rb$})  { |m| "spec/#{m[1]}/#{m[2]}_spec.rb" }

  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb"] }

  watch('app/controllers/eurocrat/application_controller.rb')  { "spec/controllers" }

  watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }

end

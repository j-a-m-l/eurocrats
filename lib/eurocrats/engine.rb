module Eurocrats
  class Engine < ::Rails::Engine
    isolate_namespace Eurocrats

    config.generators do |g|
      g.test_framework      :rspec,    fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.stylesheets false
      g.javascripts false
      g.helper false
    end

  end
end

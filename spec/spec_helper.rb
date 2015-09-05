if ENV['COVERAGE']
  puts "\n\t > COVERAGE ON"
  require 'simplecov'
end


ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../spec/dummy/config/environment.rb", __FILE__)
require 'rspec/rails'
require 'spork'
# require 'factory_girl'

Spork.prefork do

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[File.expand_path('../../spec/support/**/*.rb', __FILE__)].each {|f| require f }

  # Factories
  # Dir[File.expand_path('../../spec/factories/**/*_factory.rb', __FILE__)].each {|f| require f }

  # Checks for pending migrations before tests are run.
  # If you are not using ActiveRecord, you can remove this line.
  # ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

  RSpec.configure do |config|
    # ## Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    # config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = false

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = true

    config.infer_spec_type_from_file_location!

    # Includes the engine URL helpers on related tests
    config.include Eurocrats::Engine.routes.url_helpers, type: :controller
    config.include Eurocrats::Engine.routes.url_helpers, type: :routing

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = "random"

    # config.include FactoryGirl::Syntax::Methods

    config.before(:suite) { DatabaseCleaner.clean_with :truncation }
    config.before(:each)  { DatabaseCleaner.strategy = :transaction }
    config.before(:each)  { DatabaseCleaner.start }
    config.after(:each)   { DatabaseCleaner.clean }

    # Aliases that improves readability
    config.alias_it_should_behave_like_to :it_renders, 'renders'
    config.alias_it_should_behave_like_to :it_responds, 'responds'
    config.alias_it_should_behave_like_to :it_redirects, 'redirects'

  end
end

Spork.each_run do
end

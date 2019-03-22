ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?

if Rails.env.test?
  require 'rspec/rails'
  require 'database_cleaner'
  require 'faker'
end

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }
  Dir[Rails.root.join('spec/helpers/**/*.rb')].each { |f| require f }

  config.include FactoryBot::Syntax::Methods
  config.include Requests::JsonHelpers, type: :controller
  config.include Requests::JsonHelpers, type: :model
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

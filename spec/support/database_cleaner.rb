RSpec.configure do |config|
  config.before :suite do
    DatabaseCleaner.strategy = :truncation
  end
  config.after :each do
    DatabaseCleaner.clean
    Settings.destroy_all!
  end
end


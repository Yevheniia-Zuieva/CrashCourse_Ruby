# frozen_string_literal: true

require 'capybara'
require 'rspec'

RSpec.configure do |config|
  config.before(:each) do
    Capybara.default_driver = :selenium
    Capybara.app_host = 'https://www.saucedemo.com'
    Capybara.default_max_wait_time = 5
  end

  config.after(:each) do |example|
    if example.exception
      Dir.mkdir('screenshots') unless Dir.exist?('screenshots')
      time = Time.now.strftime('%Y-%m-%d_%H-%M-%S')
      filename = "screenshots/#{time}_#{example.description.gsub(' ', '_')}.png"
      page.save_screenshot(filename)
    end
  end
end

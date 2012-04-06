source 'http://rubygems.org'

gem 'rails', '3.1.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'mysql2'

gem 'json'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

group :cucumber do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'cucumber-rails'
  gem 'cucumber'
  gem 'rspec-rails'
  gem 'spork'
  gem 'launchy'    # So you can do Then show me the page
end
# group :cucumber do
#   gem 'webmock'
#   gem 'vcr'
#   gem "selenium-webdriver", ">= 0.2.2"
#   gem "generic_factory_steps", :git => "git@github.com:ywen/generic_factory_steps.git", :branch => "sequel"
#   gem 'cucumber-rails'
# end

group :cucumber, :test, :development, :staging do
  gem 'faker'
  gem 'factory_girl'
  gem 'factory_girl_rails', '= 1.4.0'
  gem 'capybara'
  gem 'json_spec'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'


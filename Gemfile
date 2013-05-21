source 'https://rubygems.org'

ruby "1.9.3"

gem 'rails', '3.2.13'
gem 'pg'
gem 'haml'
gem 'activeadmin'
gem 'rails-i18n'
gem "remote_table"
gem 'jquery-rails'
gem "newrelic_rpm"

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

# Development gems
##################
group :development do
  gem "guard-spork"
  gem "guard-rspec", "~> 1.2.1"
end

# Test gems
###########

group :test, :development do
  gem "rspec-rails"
  gem "sqlite3"
  gem 'pry-rails'
  gem "pry-debugger"
  gem 'awesome_print'
end

group :test do
  gem 'sqlite3'
  gem "factory_girl_rails"
  gem 'rb-fsevent', '~> 0.9.1'
end

# Production gems
#################


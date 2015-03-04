source 'https://rubygems.org'

ruby "2.1.4"

gem 'rails', '3.2.15'
gem 'pg'
gem 'haml'
gem 'activeadmin'
gem 'rails-i18n'
gem "remote_table"
gem 'jquery-rails'
gem "newrelic_rpm"
gem 'passenger', '~> 5.0.0.rc2'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

# Test gems
###########

group :test, :development do
  gem 'pry-rails'
  gem "pry-byebug"
  gem 'awesome_print'
end

# Production gems
#################

group :production do
  gem "rails_12factor"
end

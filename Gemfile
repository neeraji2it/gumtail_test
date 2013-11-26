source 'https://rubygems.org'

gem 'rails', '3.2.12'
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem "remotipart", "~> 1.0"
gem 'pg'
gem 'devise'
gem 'omniauth'
gem "omniauth-facebook"
gem 'omniauth-twitter'
gem 'fb_graph'
gem 'twitter'
gem 'stripe'
gem 'carrierwave'
gem 'rmagick'
gem 'activerecord-postgres-hstore'
gem 'fog'
gem 'rack-mini-profiler'
gem 'dalli'
gem 'memcachier'
gem 'sidekiq'
gem 'sidekiq_mailer', :git => 'git://github.com/tubaxenor/sidekiq_mailer.git', :ref => 'cc8f6d0cf941d0a43cc694e6d2e20e25081e2d03'
gem 'devise-async'
gem 'redis'
gem 'redis-namespace'
gem 'liquid'
gem 'sinatra', require: false
gem 'slim','1.3.8'
gem "temple", "~> 0.6.7"
gem "will_paginate"
gem 'annotate'
gem 'country_select'
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
group :development, :test do
	gem 'rspec-rails'
  gem 'bullet'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'compass-rails'
  gem 'jquery-fileupload-rails'
  gem 'zurb-foundation'
  gem 'handlebars_assets'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :production do
  # gems specifically for Heroku go here
  gem 'rails_12factor', '0.0.2'
end

group :test do
  gem 'faker', '1.0.1'
	gem 'capybara', '1.1.2'
	gem 'factory_girl_rails', '4.1.0'
	gem 'cucumber-rails', '1.2.1', :require => false
	gem 'database_cleaner'
  gem "email_spec", ">= 1.4.0"
  gem "shoulda-matchers"
  gem "shoulda-callback-matchers"
end


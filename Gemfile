source 'https://rubygems.org'

ruby '2.1.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.2'
# Use postgresql as the database for Active Record
gem 'pg'
gem 'jquery-rails'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Puma as the app server
gem 'puma'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'spring-commands-rspec'
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'guard-bundler', require: false
  gem 'wdm', '>= 0.1.0' if Gem.win_platform?
  gem 'ruby_gntp'
  gem 'factory_girl_rails'
  gem 'rspec_api_documentation'
  gem 'jasmine-rails'
end

group :development do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem 'annotate'
end

group :test do
  gem 'factory_girl_rspec'
  gem 'shoulda-matchers'
  gem 'shoulda-kept-respond-with-content-type'
  gem 'simplecov', require: false
end

group :production do
  gem 'rails_12factor'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'schema_plus'
gem 'kaminari'
gem 'apitome'

gem 'sprockets', '2.12.4'
gem 'angular-rails-templates', '~> 0.1.5'
gem 'bower-rails'
gem 'bootstrap-sass'

gem 'rack-cors'
gem 'slim-rails'

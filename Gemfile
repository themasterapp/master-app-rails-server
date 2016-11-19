source 'https://rubygems.org'

ruby "2.3.2"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.19'
# Use Puma as the app server
gem 'puma', '~> 3.6'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5.0', '>= 5.0.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

source 'https://rails-assets.org' do
  gem 'rails-assets-animate.css', '3.5.2'
end

# ** Views/Templates **
gem 'slim-rails', '~> 3.1'
gem 'bootstrap-sass', '3.3.7'
gem 'font-awesome-rails', '~> 4.7'
gem 'bootstrap_form', '~> 2.5'
gem 'browser', '~> 2.3'
gem 'kaminari', '~> 0.17.0'

# ** SEO **
gem 'meta-tags', '~> 2.3', '>= 2.3.1'
gem 'friendly_id', '~> 5.1'

# ** i18n **
gem 'rails-i18n', '~> 5.0'
gem 'devise-i18n', '~> 1.1'

# ** i18n **
gem 'devise', '~> 4.2'
gem 'pundit', '~> 1.1'

# Asynchronous processing
gem 'sucker_punch', '~> 2.0', '>= 2.0.2'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'pry', '~> 0.10.4'
  gem 'pry-byebug', '~> 3.4'
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '~> 3.5', '>= 3.5.2'
  gem 'i18n-tasks', '~> 0.9.6'
  gem 'dotenv-rails', '~> 2.1', '>= 2.1.1'
  gem 'faker', '~> 1.6', '>= 1.6.6'
  gem 'factory_girl_rails', '~> 4.7'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.1.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'letter_opener', '~> 1.4', '>= 1.4.1'
end

group :production do
  gem 'heroku-deflater', git: 'https://github.com/romanbsd/heroku-deflater.git', ref: '60d92ba0f8ae2'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

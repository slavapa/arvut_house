source 'http://rubygems.org'
ruby '1.9.3'
#ruby-gemset=railstutorial_rails_4_0

gem 'rails', '4.0.4'
gem 'sprockets', '2.11.0'
gem 'bcrypt-ruby', '3.1.2'
gem 'faker', '1.1.2'
gem 'will_paginate', '3.0.4'
gem 'bootstrap-will_paginate'
gem 'rails-i18n', '~> 4.0.0'

group :development, :test do
  gem 'sqlite3', '1.3.8'
  gem 'rspec-rails', '2.14.2'
  gem 'rspec-wait', '0.0.7'
  # The following optional lines are part of the advanced setup.
  gem 'guard-rspec'
  gem 'spork-rails', '4.0.0'
  gem 'guard-spork', '1.5.0'
  gem 'rubyzip'
  gem 'childprocess', '0.5.6'
end

group :test do
  gem 'selenium-webdriver', '2.35.1'
  gem 'capybara', '2.5.0 '
  gem 'factory_girl_rails', '4.2.0'
  gem 'cucumber-rails', '1.4.0', :require => false
  gem 'database_cleaner', github: 'bmabey/database_cleaner'

  # Uncomment this line on OS X.
  # gem 'growl', '1.0.3'

  # Uncomment these lines on Linux.
  #gem 'libnotify', '0.8.0'

  # Uncomment these lines on Windows.
  #gem 'rb-notifu', '0.0.4'
  #gem 'win32console', '1.3.2'
  #gem 'wdm', '0.1.0'
end

gem 'compass'
gem 'compass-rails'
gem 'sass-rails'

gem 'bootstrap-sass', '~> 2.3.2'
gem 'uglifier', '2.1.1'
gem 'coffee-rails', '4.0.1'
gem 'jquery-rails'
gem 'jquery-ui-rails' #https://github.com/joliss/jquery-ui-rails
gem 'turbolinks', '1.1.1'
gem 'jbuilder', '1.0.2'

group :doc do
  gem 'sdoc', '0.3.20', require: false
end

gem 'rails_12factor', '0.0.2'
gem 'search_object', '~> 0.1' #http://rubygems.org/gems/search_object TODO: Check version 1.0
gem 'slim'
gem "validates_existence", ">= 0.4" #http://github.com/perfectline/validates_existence


group :production do
  gem 'pg',             '0.17.1'
  gem 'unicorn',        '4.8.3'
end

gem 'acts_as_xlsx', '1.0.6'
gem 'axlsx_rails', '0.1.5'
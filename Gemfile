source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "2.5.1"

gem "bcrypt", "~> 3.1.7"
gem "bootsnap", ">= 1.1.0", require: false
gem "bootstrap", "~> 4.3", ">= 4.3.1"
gem "bootstrap-will_paginate", "~> 1.0.0"
gem "carrierwave", "1.2.2"
gem "coffee-rails", "~> 4.2"
gem "config"
gem "faker", "~> 2.1.0"
gem "font-awesome-rails", "~> 4.7", ">= 4.7.0.5"
gem "i18n-js"
gem "jbuilder", "~> 2.5"
gem "jquery-rails"
gem "mailgun-rails"
gem "mini_magick", "4.7.0"
gem "mysql2", ">= 0.4.4", "< 0.6.0"
gem "paperclip", "~> 5.1"
gem "puma", "~> 3.11"
gem "pundit"
gem "rails", "~> 5.2.3"
gem "rails-i18n"
gem "rubocop", "~> 0.54.0", require: false
gem "sass-rails", "~> 5.0"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"
gem "will_paginate", "~> 3.1.7"
gem "devise"
gem "ransack"
gem "cancancan"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "capybara", ">= 2.15"
  gem "rspec-rails", "~> 3.5"
  gem "factory_bot_rails"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "chromedriver-helper"
  gem "guard", "2.13.0"
  gem "guard-minitest", "2.4.4"
  gem "minitest", "5.10.3"
  gem "minitest-reporters", "1.1.14"
  gem "rails-controller-testing", "1.0.2"
  gem "selenium-webdriver"
  gem "sqlite3", "1.3.13"
  gem "database_cleaner"
  gem "faker", "~> 2.1.0"
  gem "launchy"
  gem "shoulda-matchers", "~> 3.0", require: false
end

group :production do
  gem "fog", "1.42"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

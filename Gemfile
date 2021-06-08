source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.0"

gem "rails", "~> 6.1.3", ">= 6.1.3.2"
gem "bootstrap-sass", "3.4.1"
gem "mysql2", "~> 0.5"
gem "puma", "~> 5.0"
gem "sass-rails", ">= 6"
gem "webpacker", "~> 5.0"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.7"
gem "bcrypt", "~> 3.1.7"
gem "image_processing", "~> 1.2"
gem "bootsnap", ">= 1.4.4", require: false
gem "config"
gem "figaro"
gem "faker", "2.1.2"
gem "will_paginate", "3.1.8"
gem "bootstrap-will_paginate", "1.0.0"
gem "devise"
gem "cancancan"
gem "pagy", "~> 3.5"
gem "ransack"
gem "sidekiq"
gem "sidekiq-scheduler"

group :development, :test do
  gem "rspec-rails", "~> 4.0.1"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "rubocop", "~> 0.74.0", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-rails", "~> 2.3.2", require: false
  gem "simplecov-rcov"
  gem "simplecov"
  gem "rails-controller-testing"
  gem "factory_bot"
  gem "database_cleaner-active_record"
  gem "shoulda-matchers", "~> 4.0"
end

group :development do
  gem "web-console", ">= 4.1.0"
  gem "rack-mini-profiler", "~> 2.0"
  gem "listen", "~> 3.3"
  gem "spring"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver"
  gem "webdrivers"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

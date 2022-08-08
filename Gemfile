source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"
gem "rails", "~> 7.0.2"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "jsbundling-rails"
gem "turbo-rails", '~> 1.0.0'
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"

gem "redis", "~> 4.0"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem "font-awesome-rails"
gem "letter_opener", group: :development

gem 'devise-i18n'
gem 'rails-i18n', '~> 7.0.0'

gem 'aws-sdk-s3'
gem 'image_processing', '~> 1.2'

gem "devise", github: "ghiculescu/devise", branch: "error-code-422"
gem "responders", github: "heartcombo/responders"
gem "pundit", "~> 2.2"

gem "omniauth-rails_csrf_protection"
gem "omniauth"
gem 'omniauth-vkontakte'
gem 'omniauth-github', github: 'omniauth/omniauth-github', branch: 'master'

group :development do
  gem "web-console"
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-passenger'
  gem 'capistrano-rbenv'
end

group :development, :test do
  gem 'pry'
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end

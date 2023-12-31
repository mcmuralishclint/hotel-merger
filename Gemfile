# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'
gem 'active_model_serializers'
gem 'bootsnap', require: false
gem 'byebug'
gem 'httparty'
gem 'mongoid', '~> 7.0'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.8'
gem 'sqlite3', '~> 1.4'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'capistrano', '~> 3.11'
gem 'capistrano-rails', '~> 1.4'
gem 'capistrano-passenger', '~> 0.2.0'
gem 'capistrano-rbenv', '~> 2.1', '>= 2.1.4'

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'simplecov'
  gem 'simplecov-json'
end

group :development do
end

# frozen_string_literal: true
# frozen_string_literal: true

source "https://rubygems.org"

ruby '3.0.2'

group :development do
  gem 'sinatra'
  gem 'sinatra-contrib'
  gem 'pg'
  gem 'rack'
end

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'simplecov', require: false 
  gem 'simplecov-console', require: false
  gem 'launchy'
end

group :development, :test do
  gem 'rubocop'
end

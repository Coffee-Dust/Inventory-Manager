source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in inventory_manager.gemspec
gemspec
require "~/Quorra.rb"
require "open-uri"

gem "colorize"
gem "require_all"

gem "nokogiri"

group :dev do
  gem "pry"
  gem "rspec", "~> 3.6"
end

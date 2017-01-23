source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.2.4'

gem 'devise'
gem 'rails', '~> 5.0.1'
gem 'pg', '~> 0.18'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'foundation-rails'
gem 'carrierwave', '~> 1.0'

group :development, :test do
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'dotenv-rails'
  gem 'launchy'
  gem 'factory_girl'
  gem 'valid_attribute'
  gem 'listen'
  gem 'shoulda-matchers', require: false
  gem 'teaspoon'
  gem 'teaspoon-jasmine'
end

group :production do
  gem 'puma', '~> 3.0'
  gem 'rails_12factor'
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

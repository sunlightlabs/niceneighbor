source 'http://rubygems.org'

gem 'rails', '3.0.10'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
gem 'ruby-debug19', :require => 'ruby-debug'

# Bundle the extra gems:
gem 'devise'
gem 'rails_admin', :git => 'git://github.com/sferik/rails_admin.git', :branch => 'rails-3.0'
gem 'acts-as-taggable-on', '~> 2.1.0'
gem 'friendly_id', '~> 4.0.0.beta8'
gem 'carrierwave'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  gem 'webrat'
  gem 'sqlite3-ruby', :require => 'sqlite3'
end

# Production environment
group :production do
  gem 'pg'
end

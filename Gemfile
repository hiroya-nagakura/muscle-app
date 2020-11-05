source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
# Use sqlite3 as the database for Active Record
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  #追加
  gem 'rspec-rails', '~> 3.6.0'
  gem 'factory_bot_rails', '~> 4.10.0'
  gem 'faker', git: 'https://github.com/stympy/faker.git', branch: 'master'
  gem 'forgery_ja'
  #rspecでrender_templateを使うため
  gem 'rails-controller-testing'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # 追加
  gem 'spring-commands-rspec'
  # 静的解析ツール
  gem 'rubocop'
  gem 'rubocop-rails'
  # N+1問題発見用
  gem 'bullet'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  #circleciでのテストで必要
  gem 'rspec_junit_formatter'
end
#自動デプロイ
group :development, :test do
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano-rbenv-vars'
  gem 'capistrano3-puma'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

#追加
#ユーザー
gem 'devise'
#DBにmysql採用
gem 'mysql2'
#画像保存
gem 'carrierwave'
gem 'mini_magick'
#日本語変換
gem 'rails-i18n'
gem 'devise-i18n'
#検索機能
gem 'ransack'
#アイコン表示
gem 'font-awesome-sass'
#ページネーション
gem 'kaminari'
gem 'ed25519'
gem 'bcrypt_pbkdf'
gem 'fog-aws'
#管理画面
gem 'activeadmin'
#メニュー記録のカレンダー
gem 'simple_calendar'
#ネストフォーム
gem "cocoon"
#グラフ
gem "chartkick"
gem 'groupdate'
# active storageをS3で保存
gem "aws-sdk-s3", require: false
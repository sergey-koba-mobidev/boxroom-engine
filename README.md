# Boxroom
[![Gem Version](https://badge.fury.io/rb/boxroom.svg)](https://badge.fury.io/rb/boxroom)
This is a Rails engine built based on code of [Boxroom](https://github.com/mischa78/boxroom) project.

# Features
It aims to be a simple interface for managing and
sharing files in a web browser. It lets users create folders and upload, download
and share files. Admins can manage users, groups and permissions.

![Boxroom](https://res.cloudinary.com/skoba/image/upload/v1518819948/Boxroom_vzqhre.png)

## Install
- add to Gemfile `gem 'boxroom'`
- run `rails boxroom:install:migrations`
- run `rails db:migrate`
- mount engine in `config/routes.rb`
```ruby
mount Boxroom::Engine => "/boxroom"
```

## Config
- Create `config/initializers/boxroom.rb`
```ruby
Boxroom.configure do |config|
  config.site_name = 'Boxroom'
  config.logo = 'boxroom/logo.png'
  config.uploads_path = 'uploads'
  config.show_footer = true
  config.show_users = true
  config.show_groups = true
  config.show_settings = true
  config.show_shared_files = true
  config.sign_out_path = nil # pass string to redirect to after sign out. '/dashboard' for example
end
```

## Contributing
Please feel free to leave an issue or PR.

## Testing
- run migrations `bin/rails db:migrate RAILS_ENV=test`
- run tests `bin/rails test`

## License
The engine is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Roadmap:
- tests for search
- tag files
- integrate with existing user model
- support s3

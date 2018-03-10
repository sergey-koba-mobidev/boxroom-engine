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
mount Boxroom::Engine => '/boxroom'
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
  config.show_search = true
end
```

## Integrate with existing User model and authentication
- Create `config/initializers/boxroom.rb`
```ruby
Boxroom.configure do |config|
  config.current_user_method = 'current_user' # a method in your application, which returns authenticated User, Boxroom's authentication is disabled
  config.sign_in_path = '/login' # pass string to redirect unauthenticated user to
  config.sign_out_path = '/logout' # pass string to redirect to after sign out, '/dashboard' for example. Or it could be sign out page of you main app
end
```
- add `boxroom` to your User model.
- Remember you can provide User model methods names instead of fields names too. For example
```ruby
# app/models/user.rb
class User < ActiveRecord::Base
  # :username and :email are attributes of User model
  boxroom name: :username, email: :email, is_admin: :is_admin? # all params are required
  
  def is_admin?
    email == 'admin@test.com' # Remember only 1 user can be a real admin
  end
end
```
- if you modify your users without callbacks in any place you should also take care of `boxroom_users` table yourself.

## Contributing
Please feel free to leave an issue or PR.

## Testing
- run migrations `bin/rails db:migrate RAILS_ENV=test`
- run tests `bin/rails test`

## License
The engine is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Roadmap:
- tag files
- integrate with existing user model tests
- support s3
- integrate with active_admin

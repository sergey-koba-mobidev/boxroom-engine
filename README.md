# Boxroom
[![Gem Version](https://badge.fury.io/rb/boxroom.svg)](https://badge.fury.io/rb/boxroom)

This is a Rails engine built based on code of [Boxroom](https://github.com/mischa78/boxroom) project.

# Features
It aims to be a simple interface for managing and
sharing files in a web browser. It lets users 
- create folders
- upload files
- download files
- share files
- search folders and files 
- sort files and folders
- notify by email when files in specific folders are created, updated or removed

Admins can:
- manage users
- manage groups
- manage access permissions

Integrates with existing User model amd authentication system.

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
  config.enable_notifications = true # notify by email when files in specific folders are created, updated or removed
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

## Mail settings

Boxroom sends email on the following occasions:

 * When inviting new users
 * On a reset password request
 * When a file is shared

For the application to be able to send email, a few things have to be set up. Depending on the environment
you're working in, either open `config/environments/development.rb` or `config/environments/production.rb`.
Uncomment the following lines and fill in the correct settings of your mail server:

```ruby
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  address: 'mailhost',
  port: 587,
  user_name: 'user_name',
  password: 'password',
  authentication: 'plain'
}
```

Also uncomment the following and replace `localhost:3000` with the host name the app will be running under:

```ruby
config.action_mailer.default_url_options = { host: 'localhost:3000' }
```

Lastly, you have to choose the address emails will be sent from. You can do
this by uncommenting and adjusting the following:

```ruby
ActionMailer::Base.default from: 'Boxroom <yourname@yourdomain.com>'
```


## Languages

Thanks to [Rob Halff](https://github.com/rhalff), [Marcus Ilgner](https://github.com/milgner),
[Jessica Marcon](https://github.com/marcontwm), [Arnaud Sellenet](https://github.com/demental),
[Burnaby John](https://github.com/john-coding) and [marcosantoniocaro](https://github.com/marcosantoniocaro)
Boxroom is now available in Dutch, German, Italian, French, Simplified Chinese and Spanish.

English is the default. To change the language, open `config/application.rb` and set the language you desire:

```ruby
config.i18n.default_locale = :en # English
config.i18n.default_locale = :nl # Dutch
config.i18n.default_locale = :de # German
config.i18n.default_locale = :it # Italian
config.i18n.default_locale = :fr # French
config.i18n.default_locale = :'zh-CN' # Simplified Chinese
config.i18n.default_locale = :es # Spanish
```

It would be great to have many more languages. I am waiting for your pull requests.

## Contributing and Development
Please feel free to leave an issue or PR.

- Use `docker-compose up -d` to launch mailcatcher on [http://localhost:1080](http://localhost:1080) 
- Update mail settings in `config/environments/development.rb`
```ruby
config.action_mailer.raise_delivery_errors = true
config.action_mailer.perform_caching = false
config.action_mailer.perform_deliveries = true
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  address: 'localhost',
  port: 1025
}
config.action_mailer.default_url_options = { :host => 'localhost:3000' }

ActionMailer::Base.default from: 'Boxroom <yourname@yourdomain.com>'
```

## Testing
- run migrations `bin/rails db:migrate RAILS_ENV=test`
- run tests `bin/rails test`

## License
The engine is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Roadmap:
- tests for notifications
- support s3
- batch actions
- tag files
- integrate with active_admin

# Boxroom
This is a Rails engine built based on code of [Boxroom](https://github.com/mischa78/boxroom) project.

# Features
It aims to be a simple interface for managing and
sharing files in a web browser. It lets users create folders and upload, download
and share files. Admins can manage users, groups and permissions.

## Install
- add to Gemfile `gem 'boxroom', github: 'sergey-koba-mobidev/boxroom-engine'`
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
  config.show_footer = true
  config.sign_out_path = nil # pass string to redirect to after sign out. '/dashboard' for example
end
```

## Contributing
Please feel free to leave an issue or PR.

## License
The engine is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## TODO:
- fix tests

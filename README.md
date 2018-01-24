# Boxroom
This is a Rails engine built based on code of [Boxroom](https://github.com/mischa78/boxroom) project.

# Features


## Install
- add to Gemfile
- run `rails boxroom:install:migrations`
- run `rails db:migrate`

## Config
- Create `config/initializers/boxroom.rb`
```ruby
Boxroom.configure do |config|
  config.site_name = 'Boxroom'
  config.logo = 'boxroom/logo.png'
end
```
- mount engine in `config/routes.rb`
```ruby
mount Boxroom::Engine => "/boxroom"
```

## Contributing
Please feel free to leave an issue or PR.

## License
The engine is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

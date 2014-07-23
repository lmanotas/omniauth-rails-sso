# Omniauth::RailsSso

This gem is an [omniauth](https://github.com/intridea/omniauth) strategy for integrating an omniauth powered app with 
[rails-sso-app](https://github.com/lmanotas/rails-sso-app), a hosted identity service and Oauth 2 provider.

## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-rails-sso'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-rails-sso

## Usage

#### Configure The Strategy

Configuration is much the same as any other omniauth strategy.

    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :rails-sso, <your client key>, <your client secret>
    end

#### Read about Omniauth Usage

If you haven't already done so, be sure to read about [omniauth](https://github.com/intridea/omniauth). It contains important information about how to setup you app for using omniauth and its strategies.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
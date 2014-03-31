# Omniauth::Josso

A Josso strategy for OmniAuth.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-josso'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install omniauth-josso
```

## Usage

```ruby
use OmniAuth::Builder do
  provider :josso, ENV['ENDPOINT_URL']
end
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/omniauth-josso/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

See the [LICENSE](https://github.com/patriciomacadden/omniauth-josso/blob/master/LICENSE).

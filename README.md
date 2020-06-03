# Somecache

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'somecache'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install somecache

## Usage

Somecache is a wrapper to cache objects (following the `read`, `write`, `fetch` and `delete` api)

The aim is to easily create custom caches (with custom namespace or expiration options)

When working with cache is easy to spread the logic of creation and deletion, like so:

```ruby
# Some Class
Rails.cache.fetch("products/#{product_id}", expires_in: 1.day) { Product.find(product_id) }

# Some Worker
Rails.cache.delete("products/#{product_id}")
```

Somecache allows you to create and use the cache without spreading cache logic (like the namespace)

```ruby
# product_cache.rb
ProductCache = Somecache::Custom.new(namespace: 'products' , cache: Rails.cache, expires_in: 1.day)

# Some Class
ProductCache.fetch(product_id) { Product.find(product_id) }

# Some Worker
ProductCache.delete(product_id)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/VAGAScom/somecache.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

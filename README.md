# MimeTypedPublicExceptions
PublicExceptions for multiple mime types

## Usage
```js
// public/500.json
{
  "status": 500,
  "message": "internal server error"
}
```

```ruby
Rails.application.configure do
  config.exceptions_app = MimeTypedPublicExceptions.new(Rails.public_path)
end
```

```ruby
app.get '/some_exception', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
# => 500
app.response_body
# => "{\n  \"status\": 500,\n  \"message\": \"internal server error\"\n}"
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'mime_typed_public_exceptions'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install mime_typed_public_exceptions
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

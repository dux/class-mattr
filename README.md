# Method attributes

class-mattr gem provides simple way to set and get method attributes.

## Installation

to install

`gem install class-mattr`

or in Gemfile

`gem 'class-mattr'`

and to use

`require 'class-mattr'`

## How to use

* include `ClassMattr`
* define method attributes via `mattr.name argument`
* get them via `mattr :name` (class and instance method provided)

```ruby
class Foo
  include ClassMattr

  mattr.name 'Test method'
  mattr.opt  guest: true
  def test
  end

  def get
    mattr :test # get :test method attributes
  end
end
```

### Real world scenario

Protect all urls in a way that user has to have a session (`current_user` is defined),
but allow to bypass that rule if `mattr.guest_access` is defined

Optionaly you can define array of method names as sysbols for `mattr` method, to be able to use them without `mattr.` prefix.

```ruby
class ApplicationController < ActionController::Base
  include ClassMattr

  # allow usage without mattr prefix
  mattr [:guest_access]

  before_action do
    # get all method attributes
    opts = mattr params[:action]

    if !opts[:guest_only] && !current_user
      redirect_to '/login', info: 'You must log in to access this resource'
    end
  end
end

class UserController < ApplicationController
  # mattr.guest_access, aliased trough class method
  # default argument is true, if nil defined
  guest_access
  def login
    # ...
  end

  def profile
    # ...
  end
end
```

### Manual hash get

If you need, you can get method attributes hash manualy

```ruby
class ClassA
  include ClassMattr

  mattr.foo 123
  mattr.opt name: 'Dux'

  mattr.get_hash # { foo:123, name: 'Dux' }
end
```

## Dependency

none

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rspec` to run the tests.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dux/class-mattr.
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the
[Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

# UniqueId

This ActiveRecord extension keeps track of number ranges and easily creates valid sequential formatted identifiers which could be used for invoices, orders, personnel numbers and the like. Did you ever want to generate invoice IDs like this?

* INV-0001
* INV-0002
* INV-0002

That's what UniqueId does.

## Installation

Add this line to your application's Gemfile:

    gem 'unique_id'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install unique_id

## Usage

Create a database attribute which will hold the id, and activate unique_id to use it:

````
class Invoice
  has_unique :inv_id
end
````

In this example, `inv_id` is the attribute of our model `Invoice` which will hold the id once it has been created. It needs to be a string attribute, your application is responsible for creating and indexing it as appropriate.

There are some options that can be set. These are the defaults:

````
class Invoice
  has_unique :inv_id,
  	start: 1,
  	scoped_by: nil,
  	formatter: nil
end
````

#### start

Numbering starts with this value for each number range. Can be set per model.

#### scoped_by

A number is guaranteed to be unique within a *scope*. While the default is blank, this could be used for revolving number ranges, eg. to start over the numbers each year:

````
class Invoice
  has_unique :inv_id,
  	scoped_by: proc { Time.now.year }
end
````

The scope will be set to the return value of the proc and will be evaluated every time a new identifier is generated. In this example numbering will start over each year.

#### formatter

By default a unique_id will simple be an integer value. You can define a formatter to make it look however you like:

````
class Invoice
  has_unique :inv_id,
  	formatter: proc { |scope, value| sprintf("INV-%04d", value) }
end
````

Like this, the `uid` attribute will be filled with values `INV-0001`, `INV-0002`, `INV-0003`…


## Contributing

1. Fork it ( https://github.com/[my-github-username]/unique_id/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

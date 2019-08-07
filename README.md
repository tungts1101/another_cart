# another_cart
Yet another implementation for shopping cart, really simple and easy to use.

## Installation
* Add `gem "kart"` to Gemfile
* Run `bundle install`

## Usage
**Make sure to create [User] and [Product] model beforehand**
* `rails generate cart [User] [Product]`\
example: `rails g cart Member Book` will create a cart contains books selected by a member.
* `rails db:migrate`
these files created by this command are self-explanatory.
* insert `selecting :product` to [User] and `selected_by :user` to [Product].
* execute `show_cart` instance method to get current cart of user.

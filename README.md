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

## Export methods
* `selecting_products`: list of products are selected by current user
* `show_cart`: list of product id and quantity in cart of current user
* `add_to_cart (Product)`: add 1 product to cart
* `remove_from_cart (Product)`: remove 1 product from cart
* `remove_all_from_cart`: remove all products from cart (when checking out successfully)

## Handling exception
* **Kart::UserNotDefined**: insert `selected_by` into Product model
* **Kart::ProductNotDefined**: insert `selecting` into User model
* **Kart::ItemNotFound**: item need to be added to cart before removed 

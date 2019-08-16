require "kart/version"
require "active_support/concern"
require "kart/railtie" if defined?(Rails)
require "kart/error"

module Kart
  extend ActiveSupport::Concern

  included do
    @@user_cname = "user"
    @@product_cname = "product"

    def self.selecting product
      @@product_cname = product

      has_many :carts
      has_many :selecting_products, through: :carts, source: product

      define_method "show_cart" do
        Cart.where _user => self.id
      end

      define_method "add_to_cart" do |product|
        item = Cart.find_by _user => self.id, _product => product.id

        if item.nil?
          Cart.new(_user => self.id, _product => product.id, :quantity => 1).save
        else
          item.quantity += 1
          item.save
        end
      end

      define_method "remove_from_cart" do |product|
        item = Cart.find_by _user => self.id, _product => product.id

        if item.nil?
          raise Kart::ItemNotFound, "Item was not added to cart"
        else
          item.quantity -= 1

          (item.quantity == 0) ? item.destroy : item.save
        end
      end

      define_method "remove_all_from_cart" do
        Cart.where(_user => self.id).destroy_all
      end

      define_method "add_multiple_to_cart" do |product, number|
        item = Cart.find_by _user => self.id, _product => product.id

        if item.nil?
          Cart.new(_user => self.id, _product => product.id, :quantity => number).save
        else
          item.quantity += number
          item.save
        end
      end
    end

    def self.selected_by user
      @@user_cname = user

      has_many :carts
      has_many :selected_users, through: :carts, source: user
    end

    private

    def _user
      if @@user_cname.nil?
        raise Kart::UserNotDefined, "Insert selected_by into [Product] model"
      else
        (@@user_cname.to_s + "_id").to_sym
      end
    end

    def _product
      if @@product_cname.nil?
        raise Kart::ProductNotDefined, "Insert selecting into [User] model"
      else
        (@@product_cname.to_s + "_id").to_sym
      end
    end
  end
end

require "kart/version"
require "active_support/concern"
require "kart/railtie" if defined?(Rails)

module Kart
  extend ActiveSupport::Concern
   
  included do
    def self.selecting product
      has_many :carts
      has_many :selecting_products, through: :carts, source: product

      define_method "show_cart" do
        selecting_products
      end
    end

    def self.selected_by user
      has_many :carts
      has_many :selected_users, through: :carts, source: user
    end
  end  
end

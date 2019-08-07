class CreateCarts < ActiveRecord::Migration[<%= "#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}" %>]
  def change
    create_table :carts do |t|
      t.integer <%= user_id %>
      t.integer <%= product_id %>
      t.integer :quantity
      t.timestamps
    end

  add_index(:carts, [<%= user_id %>, <%= product_id %>])
  
  end 
end

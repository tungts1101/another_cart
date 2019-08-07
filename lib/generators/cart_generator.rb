require 'rails/generators/active_record'

class CartGenerator < ActiveRecord::Generators::Base
  attr_accessor :user_cname, :product_cname
  source_root File.expand_path 'templates', __dir__

  def initialize *args
    @user_cname = args[0][0]
    @product_cname = args[0][1]
    super
  end
  
  def ensure_defined
    ensure_classes_defined [:user, :product]
  end

  def generate_model
    invoke "active_record:model", [ "cart" ], :migration => false
    
    inject_into_class model_path, Cart, model_content 
  end
  
  def copy_cart_migration
    migration_template "migration.rb", "db/migrate/create_carts.rb"
  end

  private
 
  def model_path
    File.join("app", "models", "cart.rb")
  end 

  def model_content
    ERB.new(File.read(File.join(__dir__, 'templates/model.rb'))).result(binding)
  end

  def user_id
    ":#{@user_cname.downcase}_id"
  end

  def product_id
    ":#{@product_cname.downcase}_id"
  end

  def ensure_classes_defined cnames
    cnames.each{|cname| ensure_class_defined cname}
  end
 
  def ensure_class_defined cname
    table_name = eval("@#{cname}_cname").downcase.pluralize

    unless ActiveRecord::Base.connection.table_exists? table_name
      prompt_missing table_name
      abort
    end
  end

  def prompt_missing table_name
    puts "Table #{table_name} is missing"
  end
end

require 'kart'
require 'rails'

module Kart
  class Railtie < Rails::Railtie
    initializer 'kart' do
      ActiveSupport.on_load :active_record do
        include Kart
      end
    end
  end
end

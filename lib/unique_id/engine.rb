require 'rails/engine'

module UniqueId
  class Engine < Rails::Engine
    engine_name :unique_id

    ActiveSupport.on_load :active_record do
      include ::UniqueId::Base
    end
  end
end

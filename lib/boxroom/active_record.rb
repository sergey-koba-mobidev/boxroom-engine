ActiveSupport.on_load(:active_record) do
  include Boxroom::Models::InstanceMethods
  extend Boxroom::Models::ClassMethods
end
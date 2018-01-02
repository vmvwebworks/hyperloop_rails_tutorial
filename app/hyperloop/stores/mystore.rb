#/app/hyperloop/stores/mystore.rb

class MyStore < Hyperloop::Store

  state show_field: false, reader: true, scope: :class
  state :field_value, reader: true, scope: :class

  def self.toggle_field
    mutate.show_field !show_field
    mutate.field_value ""
  end

end

class AddDefaultValueToItemDisabledColumn < ActiveRecord::Migration[5.1]
  def change
    change_column_default :items, :disabled, false
  end
end

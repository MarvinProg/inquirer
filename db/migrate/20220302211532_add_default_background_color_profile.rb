class AddDefaultBackgroundColorProfile < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :color_background_user, :string, default: "#005a55"
  end
end

class CreatePowerSupplies < ActiveRecord::Migration
  def change
    create_table :power_supplies do |t|

      t.timestamps null: false
    end
  end
end

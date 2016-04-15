class CreateMotors < ActiveRecord::Migration
  def change
    create_table :motors do |t|

      t.timestamps null: false
    end
  end
end

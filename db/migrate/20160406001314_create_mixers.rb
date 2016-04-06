class CreateMixers < ActiveRecord::Migration
  def change
    create_table :mixers do |t|
      t.string :type
      t.integer :gpio

      t.timestamps null: false
    end
  end
end

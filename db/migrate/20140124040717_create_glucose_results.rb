class CreateGlucoseResults < ActiveRecord::Migration
  def change
    create_table :glucose_results do |t|
      t.integer :user_id
      t.datetime :date_time_stamp
      t.integer :result
      t.string :device
      t.string :notes
      t.boolean :in_use

      t.timestamps
    end
  end
end

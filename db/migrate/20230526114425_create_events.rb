class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :event_name
      t.datetime :start_time
      t.datetime :end_time
      t.string :description
      t.string :resource
      t.string :person_name

      t.timestamps
    end
  end
end

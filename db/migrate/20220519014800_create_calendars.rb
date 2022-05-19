class CreateCalendars < ActiveRecord::Migration[6.1]
  def change
    create_table :calendars do |t|

      t.integer :user_id, null: false
      t.integer :sleeping_time, null: false

      t.timestamps
    end
  end
end

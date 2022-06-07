class AddMonthToCalendar < ActiveRecord::Migration[6.1]
  def change
    add_column :calendars, :month, :integer
  end
end

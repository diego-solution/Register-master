class ReallyAddStartTimeToEvent < ActiveRecord::Migration[5.1]
  def change
    rename_column :events, :start_date, :registration_start_date
    rename_column :events, :end_date, :event_end_date
    add_column :events, :event_start_date, :datetime
  end
end

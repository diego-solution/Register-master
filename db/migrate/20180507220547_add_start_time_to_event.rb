class AddStartTimeToEvent < ActiveRecord::Migration[5.1]
  def change
    # add_column :events, :start_time, :time
    add_column :events, :end_date, :datetime
    #add_column :events, :end_time, :time
    add_column :events, :time_zone, :string
  end
end

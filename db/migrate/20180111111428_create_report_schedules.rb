# frozen_string_literal: true

class CreateReportSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :report_schedules do |t|
      t.references :team, foreign_key: true
      t.string :period
      t.datetime :start_date

      t.timestamps
    end
  end
end

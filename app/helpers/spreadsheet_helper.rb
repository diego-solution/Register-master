# frozen_string_literal: true

# helpers for exporting spreadsheets
module SpreadsheetHelper
  def build_spreadsheet(rows)
    io = StringIO.new
    xlsx = Xlsxtream::Workbook.new(io)
    xlsx.write_worksheet "Sheet1" do |sheet|
      rows.each do |row|
        sheet << row
      end
    end
    # Writes metadata and ZIP archive central directory
    xlsx.close
    io.close
    io.string
  end
end

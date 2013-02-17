require './ship'
require './format_factory'

class Report
  attr_reader :title, :text

  def initialize(ship)
    @title = "USS Enterprise Report"
    logs = ship.logs.where(
      "date >= '#{Time.now.year}-01-01' AND state=?",
      "active"
    ).order("date DESC")

    @text = logs.map do |log|
      "#{log.date}: #{log.message} (#{log.alert_level})"
    end
  end

  def generate(format)
    begin
      Format.find(format).generate(self)
    rescue Format::NotFoundException
      raise "Unknown report format: #{format.inspect}"
    end
  end
end


require './ship'

class Report
  def initialize(ship)
    @title = "USS Enterprise Report"
    logs = ship.logs.where(
      "date >= '#{Time.now.year}-01-01' AND state=?",
      "active"
    ).order("date DESC")

    @text = logs.map do |log|
      status = "#{log.date}: #{log.message} (#{log.alert_level})"
    end
  end

  def plain_format
    output = []
    output << "###### #{@title} ######"
    @text.each do |line|
      output << line
    end
    output.join "\n"
  end

  def html_format
    output = "<html>"
    output << "  <head>"
    output << "    <title>#{@title}</title>"
    output << "  </head>"
    output << "  <body>"
    @text.each do |line|
      output << "  <p>#{line}</p>"
    end
    output << "  </body>"
    output << "</html>"
    output
  end

  def json_format
    output = { title: @title, lines: [] }
    @text.each do |line|
      output[:lines] << line
    end

    output
  end

  def generate(format)
    begin
      self.send :"#{format.to_s}_format"
    rescue NoMethodError => e
      raise "Unknown report format: #{format.inspect}"
    end
  end
end


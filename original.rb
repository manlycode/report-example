#
# The goal of this exercise is work on identifying abstraction which helps simplify, document,
# and separate the concerns going on in file.
# 
# Exercise:
#   * Find related ideas in the below code
#   * Abstract them out (methods, modules, classes, etc, you pick!)
#   * If you find multiple ways, then do a separate gist for each way. 
#   * Rinse repeat until you see no other ways.
#
# Note: there is not enough of the code-base to run this code, so in order to run
#   the code you'll have to implement the missing pieces.
#

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

  def generate(format)
    if format == :plain
      output = []
      output << "###### #{@title} ######"
      @text.each do |line|
        output << line
      end
      output.join "\n"
    elsif format == :html
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
    elsif format == :json
      output = { title: @title, lines: [] }
      @text.each do |line|
        output[:lines] << line
      end
      output
    else
      raise "Unknown report format: #{format.inspect}"
    end
  end
end


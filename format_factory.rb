class Format
  class NotFoundException < RuntimeError; end

  def self.find(type)
    case type
    when :plain
      PlainFormat.new
    when :html
      HtmlFormat.new
    when :json
      JsonFormat.new
    else
      raise Format::NotFoundException
    end
  end

  def generate(report)
    raise "Override Me"
  end
end

class PlainFormat < Format
  def generate(report)
    [].tap do |output|
      output << "###### #{report.title} ######"
      output << report.text.join("\n")
    end.join "\n"
  end
end

class HtmlFormat < Format
  def generate(report)
    body do
      header(report.title) +
      log_entries(report.text)
    end
  end

  private
  def body(&block)
    """
    <html>
      <body>
      #{yield}
      </body>
    </html>
    """
  end

  def header(title)
    """
    <head>
      <title>#{title}</title>
    </head>
    """
  end

  def log_entries(lines)
    lines.map {|l| "<p>#{l}</p>"}.join "\n"
  end
end

class JsonFormat < Format
  def generate(report)
    {title: report.title, lines: report.text}
  end
end


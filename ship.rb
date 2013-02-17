class Ship
  class Logs
    attr_accessor :date, :message, :alert_level

    def initialize(date, message, alert_level)
      @date = date
      @message = message
      @alert_level = alert_level
    end

    def self.where(*args)
      self
    end

    def self.order(*args)
      [
        new(Time.now - 60, "First event happened", "WARNING"),
        new(Time.now - 80, "Second event happened", "ERROR"),
        new(Time.now - 100, "Third event happened", "DEBUG"),
        new(Time.now - 300, "Fourth event happened", "WARNING")
      ]
    end
  end

  def logs
    Ship::Logs
  end
end

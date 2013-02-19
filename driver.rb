require './classical'

ship = Ship.new
report = Report.new(ship)
puts report.generate(:chris)

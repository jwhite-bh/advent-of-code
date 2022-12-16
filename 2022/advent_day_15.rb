require 'pry'

def manhattan((x1, y1), (x2, y2))
  (y2 - y1).abs + (x2 - x1).abs
end

def tuning_frequency(lines, sensors, max_range)
  lines[0].product(lines[1]).map { |c1, c2| (c2 - c1) / 2 }
    .select { |y| y.is_a? Integer }
    .select { |y| (0..max_range).include? y }
    .uniq
    .each do |y_coord|
      ranges = sensors.map { |(x, y), r|
        r -= (y_coord - y).abs
        [x - r, x + r]
      }.select { |a, b| b > a }.sort

      col = ranges.first.first

      ranges.each do |x1, x2|
        if col >= x1 && col <= x2
          col = x2 + 1
        elsif x1 > col
          binding.pry
          return y_coord + col * 4000000
        end
      end
    end
end

file = File.open('inputs/2022_15.txt')

file_data = file.readlines.map(&:chomp)

locations = Array.new
sensors = Array.new

file_data.each do |line|
  coords = line.scan(/-?\d+/).map(&:to_i)
  sensor = [coords[0], coords[1]]
  beacon = [coords[2], coords[3]]
  locations.push sensor, beacon

  sensors.push [sensor, manhattan(sensor, beacon)]
end

x_min, x_max = nil, nil
row = 2000000

sensors.map { |sensor, distance|
  y_delta = (row - sensor[1]).abs
  distance -= y_delta

  if distance > 0
    x_vals = [sensor[0] - distance, sensor[0] + distance]
    x_vals.push x_min, x_max unless x_min.nil?

    x_min, x_max = x_vals.minmax
  else
    nil
  end
}.compact

positions =  (x_min..x_max).count { |x| !locations.include?([x, row]) }

max_range = row * 2

lines = sensors.map { |(x, y), r|
  [[x - y + r, x - y - r],
  [x + y + r, x + y - r]]
}.transpose.map(&:flatten)

puts "Positions that cannot contain a beacon: #{positions}"

puts "Tuning Frequency: #{tuning_frequency(lines, sensors, max_range)}"

file.close

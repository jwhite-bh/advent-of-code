def contained(ranges)
  range_one = (ranges[0]..ranges[1])
  range_two = (ranges[2]..ranges[3])

  range_one.cover?(range_two) || range_two.cover?(range_one)
end

def overlap(ranges)
  range_one = (ranges[0]..ranges[1])
  range_two = (ranges[2]..ranges[3])

  range_one.cover?(ranges[2]) || range_one.cover?(ranges[3]) || range_two.cover?(ranges[0]) || range_two.cover?(ranges[1])
end

file = File.open('2022_4.txt')

file_data = file.readlines.map(&:chomp).reject(&:empty?)

count = 0

file_data.each do |assign|
  # First Puzzle
  # count += 1 if contained(assign.scan(/\b\d+\b?/).map(&:to_i))

  # Second Puzzle
  count += 1 if overlap(assign.scan(/\b\d+\b?/).map(&:to_i))
end

puts "Count: #{count}"

file.close

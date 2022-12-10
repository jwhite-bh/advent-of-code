require 'pry'
file = File.open('inputs/2021_2.txt')

file_data = file.readlines.map(&:chomp)

x, y, aim = 0,0,0

file_data.each do |ins|
  arr = ins.split(' ')

  # First Puzzle
  # case arr[0]
  # when 'forward'
  #   x += arr[1].to_i
  # when 'up'
  #   y -= arr[1].to_i
  # when 'down'
  #   y += arr[1].to_i
  # end

  # Second Puzzle
  case arr[0]
  when 'forward'
    x += arr[1].to_i
    y += arr[1].to_i * aim
  when 'up'
    aim -= arr[1].to_i
  when 'down'
    aim += arr[1].to_i
  end
end

puts "Final: #{x * y}"

file.close

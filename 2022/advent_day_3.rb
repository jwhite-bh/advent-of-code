def get_char_val(char)
  char_array = ('a'..'z').to_a

  value = 0

  value += 26 if char.upcase == char

  value + char_array.find_index(char.downcase) + 1
end

file = File.open('2022_3.txt')

file_data = file.readlines.map(&:chomp).reject { |x| x.empty? }

sum = 0

# file_data.each do |ruck|
file_data.each_slice(3) do |ruck|
  # First puzzle
  # first, second = ruck.chars.each_slice(ruck.length / 2).map(&:join)

  # intersection = first.scan(/./) & second.scan(/./)

  # Second Puzzle
  intersection = ruck[0].scan(/./) & ruck[1].scan(/./) & ruck[2].scan(/./)

  sum += get_char_val(intersection.first)
end

puts "Sum: #{sum}"

file.close

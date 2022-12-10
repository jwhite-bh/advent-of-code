file = File.open('inputs/2021_1.txt')

file_data = file.readlines.map(&:chomp)

increased = 0

previous_sum_depth = 0

file_data.each_with_index do |depth, i|
  sum_depth = depth.to_i + file_data[i + 1].to_i + file_data[i + 2].to_i
  if i.zero?
    puts "#{sum_depth} (N/A - no previous measurement)"
  elsif sum_depth > previous_sum_depth
    increased += 1
    puts "#{sum_depth} (increased)"
  else
    puts "#{sum_depth} (decreased)"
  end

  break if file_data[i + 2] == file_data.last

  previous_sum_depth = sum_depth
end

puts "Increased: #{increased}"

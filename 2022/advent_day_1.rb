file = File.open('inputs/2022_1.txt')

file_data = file.readlines.map(&:chomp)

calories = 0

cal_arr = []

file_data.each do |cal|
  if cal.empty?
    cal_arr.append(calories)
    calories = 0
  else
    calories += cal.to_i
  end
end

puts "Sum of most calories is: #{cal_arr.max}"

puts "Sum of most 3 calories is: #{cal_arr.sort.last(3).sum}"

file.close

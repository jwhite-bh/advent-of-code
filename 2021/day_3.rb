require 'pry'
file = File.open('inputs/2021_3.txt')

file_data = file.read
bin_len = file_data[0..file_data.index("\n")].length - 1

g,e = "",""
o,c = file_data.split("\n"),file_data.split("\n")

(0..bin_len - 1).each do |i|
  file_data.gsub!("\n", '')
  power = (i..file_data.size - 1).step(bin_len).map { |i| file_data[i] }.group_by(&:itself).values
  # binding.pry

  g += power.max_by(&:size).first
  e += power.min_by(&:size).first

  unless o.length == 1
    o_str = o.join('')
    oxy = (i..o_str.size - 1).step(bin_len).map { |i| o_str[i] }.group_by(&:itself).values
    max = oxy.max_by(&:size).first
    min = oxy.min_by(&:size).first
    selector = min == max ? "1" : max
    o.select! { |bin| bin[i] == selector} unless o.length == 1
  end

  unless c.length == 1
    c_str = c.join('')
    co2 = (i..c_str.size - 1).step(bin_len).map { |i| c_str[i] }.group_by(&:itself).values
    max = co2.max_by(&:size).first
    min = co2.min_by(&:size).first
    selector = min == max ? "0" : min
    c.select! { |bin| bin[i] == selector} unless c.length == 1
  end
end

puts "Power Consumption: #{g.to_i(2) * e.to_i(2)}"
puts "Life Support: #{o[0].to_i(2) * c[0].to_i(2)}"
file.close

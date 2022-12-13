require 'pry'
require 'json'

def ordered?(arr_1, arr_2)
  max_i = [arr_1.size, arr_2.size].max - 1

  (0..max_i).each do |i|
    left_input = arr_1[i]
    right_input = arr_2[i]

    return true if left_input.nil? && !right_input.nil?
    return false if !left_input.nil? && right_input.nil?

    left_input = [left_input] if right_input.is_a?(Array) && !left_input.is_a?(Array)
    right_input = [right_input] if left_input.is_a?(Array) && !right_input.is_a?(Array)

    unless left_input.is_a?(Array)
      return true if left_input < right_input
      return false if right_input < left_input
      next
    end

    ordered = ordered?(left_input, right_input)

    return ordered unless ordered.nil?
  end
  nil
end

def sort_packs(left, right)
  in_order = ordered?(left, right)

  return 0 if in_order.nil?
  return -1 if in_order
  1
end


file = File.open('inputs/2022_13.txt')

file_data = file.readlines.map(&:chomp)

index = 1
sum = 0
packets = []

file_data.each_slice(3) do |line|
  line_1 = JSON.parse(line[0])
  line_2 = JSON.parse(line[1])
  packets.push(line_1, line_2)


  sum += index if ordered?(line_1, line_2)
  index += 1
end

packets.push([[2]], [[6]])

packets = packets.sort { |x, y| sort_packs(x, y) }

puts "sum of ordered indexes: #{sum}"
puts "decoder key: #{(packets.index([[2]]) + 1) * (packets.index([[6]]) + 1)}"

file.close

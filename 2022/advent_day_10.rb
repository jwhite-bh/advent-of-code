require 'pry'
file = File.open('inputs/2022_10.txt')

file_data = file.readlines.map(&:chomp)

def div_forty?(num)
  (num % 40).zero?
end

def sprite_vis?(row_i, addx)
  (row_i - addx).abs <=1
end

def reset_row(row)
  puts row
  ''
end

cycle = 0
addx = 1
sig_str = []
row = ''

file_data.each do |ins|
  (1..ins.split.size).each do |i|
    row += sprite_vis?(cycle % 40, addx) ? '#' : '.'

    cycle += 1

    row = reset_row(row) if div_forty?(cycle)

    sig_str.push(addx * cycle) if div_forty?(cycle + 20)

    addx += ins.split(' ').last.to_i if i == 2
  end
end

puts "\nSignal Strengths: #{sig_str.sum}"

file.close

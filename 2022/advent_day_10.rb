require 'pry'
file = File.open('inputs/2022_10.txt')

file_data = file.readlines.map(&:chomp)

cycle = 0
addx = 1
sig_str = []
row = ''

file_data.each do |ins|
  if ins == 'noop'
    row += ((cycle % 40) - addx).abs <=1 ? '#' : '.'
    cycle += 1

    if cycle % 40 == 0
      p row
      row = ''
    end

    sig_str.push(addx * cycle) if (cycle + 20) % 40 == 0
  else
    row += ((cycle % 40) - addx).abs <=1 ? '#' : '.'
    cycle += 1

    if cycle % 40 == 0
      p row
      row = ''
    end

    sig_str.push(addx * cycle) if (cycle + 20) % 40 == 0

    row += ((cycle % 40) - addx).abs <=1 ? '#' : '.'
    cycle += 1

    if cycle % 40 == 0
      p row
      row = ''
    end

    sig_str.push(addx * cycle) if (cycle + 20) % 40 == 0

    addx += ins.split(' ').last.to_i
  end
end

p "Signal Strengths: #{sig_str.sum}"

file.close

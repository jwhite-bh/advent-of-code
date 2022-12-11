require 'pry'
file = File.open('inputs/2022_11.txt')

file_data = file.readlines.map(&:chomp)

monkeys = []

file_data.each_slice(7) do |line|
  start_items = line[1].scan(/\b{1}\d\d?\b?/).map(&:to_i)
  operation = [line[2].scan(/ \W /).last.strip, line[2].split('=').last.split(/\W/).reject(&:empty?)].flatten!
  test_num = line[3].scan(/\d\d?/).last.to_i
  actions = [line[4][-1].to_i, line[5][-1].to_i]

  monkeys.append([start_items, operation, test_num, actions])
end

inspected = (0..monkeys.size - 1).to_a.map { |i| i = 0 }
lcm  = monkeys.map { |mon| mon[2] }.reduce(1 , :lcm)

# part 1
# rounds = 20

# part 2
rounds = 10000

rounds.times do
  monkeys.each_with_index do |monkey, i|
    monkey[0].size.times do
      item = monkey[0].shift

      x = monkey[1][1] == 'old' ? item : monkey[1][1].to_i
      y = monkey[1][2] == 'old' ? item : monkey[1][2].to_i

      # part 1
      # item = x.send(monkey[1][0], y)/3

      # part 2
      item = x.send(monkey[1][0], y) % lcm

      inspected[i] += 1

      monkey_i  = item % monkey[2] == 0 ? monkey[3][0] : monkey[3][1]

      monkeys[monkey_i][0].append(item)
    end
  end
end

inspected.sort!

puts "Monkey Business Level: #{inspected[-1] * inspected[-2]}"

file.close

file = File.open('inputs/2022_5.txt')

file_data = file.readlines.map(&:chomp)

ins_data = file_data.pop(file_data.size - file_data.find_index('') - 1)
file_data.pop(2)

stacks = []

file_data.size.times do
  stack_row = file_data.pop.scan(/...\s?/).map(&:strip)

  stack_row.each_with_index do |r, i|
    stacks[i] = [] if stacks[i].nil?
    stacks[i].append(r.scan(/\w/).first) unless r.empty?
  end
end

ins_data.each do |ins|
  steps = ins.scan(/\b\d+\b?/).map(&:to_i)

  # First puzzle
  steps[0].times do
    stacks[steps[2] - 1].append(stacks[steps[1] - 1].pop)
  end

  # Second Puzzle
  # stacks[steps[2] - 1].append(stacks[steps[1] - 1].pop(steps[0])).flatten!
end

puts stacks.map(&:last).join('')

file.close

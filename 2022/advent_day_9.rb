require 'pry'
file = File.open('inputs/2022_9.txt')

file_data = file.readlines.map(&:chomp)

knots = (0..9).to_a.map { |i| i = [0, 0] }

visited = []
visited.append(knots[-1].dup)

file_data.each do |ins|
  ins = ins.split(' ')

  ins[1].to_i.times do
    case ins[0]
    when 'R'
      knots[0][1] +=1
    when 'L'
      knots[0][1] -=1
    when 'U'
      knots[0][0] +=1
    when 'D'
      knots[0][0] -=1
    end

    knots.each_with_index do |knot, i|
      next if i == 0

      y_diff = knots[i - 1][0] - knot[0]
      x_diff = knots[i - 1][1] - knot[1]

      if x_diff.abs > 1 || y_diff.abs > 1
        knot[1] += x_diff > 0 ? 1 : -1 unless x_diff.zero?
        knot[0] += y_diff > 0 ? 1 : -1 unless y_diff.zero?
      end
    end


    visited.append(knots[-1].dup)
  end
end

puts "Visited: #{visited.uniq.size}"

file.close

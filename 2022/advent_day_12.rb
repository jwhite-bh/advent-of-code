require 'pry'
def get_char_val(char)
  char_array = ('a'..'z').to_a

  char_array.find_index(char.downcase) + 1
end

def can_visit?(curr_i, dest_i)
  @matrix[dest_i[0]][dest_i[1]] - @matrix[curr_i[0]][curr_i[1]] <= 1
end

def above(curr_i)
  return nil if curr_i[0] - 1 < 0
  return nil unless can_visit?(curr_i, [curr_i[0] - 1, curr_i[1]])

  [curr_i[0] - 1, curr_i[1]]
end

def left(curr_i)
  return nil if curr_i[1] - 1 < 0
  return nil unless can_visit?(curr_i, [curr_i[0], curr_i[1] - 1])

  [curr_i[0], curr_i[1] - 1]
end

def right(curr_i)
  return nil if curr_i[1] + 1 > @matrix.first.size - 1
  return nil unless can_visit?(curr_i, [curr_i[0], curr_i[1] + 1])

  [curr_i[0], curr_i[1] + 1]
end

def below(curr_i)
  return nil if curr_i[0] + 1 > @matrix.size - 1
  return nil unless can_visit?(curr_i, [curr_i[0] + 1, curr_i[1]])

  [curr_i[0] + 1, curr_i[1]]
end

def shortest_path(start_index, end_index)
  to_visit = [{location: start_index, distance: 0}]
  visited = []

  until to_visit.empty? do
    i = to_visit.shift

    next if visited.include?(i[:location])

    visited.append(i[:location])

    return i[:distance] if i[:location] == end_index

    [above(i[:location]), below(i[:location]), left(i[:location]), right(i[:location])].reject(&:nil?).each do |dest|
      to_visit.append({location: dest, distance: i[:distance] + 1})
    end
  end

  return 0
end

file = File.open('inputs/2022_12.txt')

file_data = file.readlines.map(&:chomp)

start_index = []
end_index = []
@matrix = []

file_data.each_with_index do |line, i|
  line_arr = line.split('')
  s_index = line_arr.find_index('S')
  e_index = line_arr.find_index('E')

  unless s_index.nil?
    start_index = [i, s_index]
    line_arr[s_index] = 'a'
  end

  unless e_index.nil?
    end_index = [i, e_index]
    line_arr[e_index] = 'z'
  end

  @matrix.append(line_arr.map { |i| get_char_val(i) })
end

puts "Shortest Path: #{shortest_path(start_index, end_index)}"

paths = []

starts = []

@matrix.each_with_index { |r, i| r.each_with_index { |c, j| starts.append([i, j]) if c == 1 } }

starts.each { |start| paths.append(shortest_path(start, end_index)) }

puts "Shortest path from any start: #{paths.reject(&:zero?).min}"

file.close

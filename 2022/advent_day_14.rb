require 'pry'

def add_boundary(edge, max_y)
  case edge
  when 'left'
    @matrix.each_with_index { |r, i| i == max_y + 2 ? r.unshift('#') : r.unshift(' ') }
    @start[0] += 1
  when 'right'
    @matrix.each_with_index { |r, i| i == max_y + 2 ? r.append('#') : r.append(' ') }
  end
end

def next_position(x,y)
  [[0, 1], [-1, 1], [1, 1]].each do |dx, dy|
    return [false, x + dx, y + dy] if @matrix[y + dy][x + dx] == ' '
  end

  [true, x, y]
end

file = File.open('inputs/2022_14.txt')

file_data = file.read

min_x, max_x = file_data.scan(/(\d{3}),/).flatten.map(&:to_i).minmax
max_y = file_data.scan(/,(\d{1,})/).flatten.map(&:to_i).max

file_data = file_data.split("\n")\

@matrix = Array.new(max_y + 3) { Array.new(max_x - min_x , ' ') }
@matrix.last.collect! { |i| '#' }
@matrix[0][500 - min_x] = '+'

file_data.each do |line|
  line.scan(/(\d{3}),(\d{1,})/).each_cons(2) do |coord, next_coord|
    if coord[1] != next_coord[1]
      y_coords = [coord[1].to_i, next_coord[1].to_i]

      @matrix[y_coords.min..y_coords.max].each { |r| r[coord[0].to_i - min_x] = '#' }
    else
      x_coords = [coord[0].to_i - min_x, next_coord[0].to_i - min_x]

      (x_coords.min..x_coords.max).each { |x| @matrix[coord[1].to_i][x] = '#' }
    end
  end
end

units = 0
@start = [500 - min_x, 0]

# part 1
# free_fall = false

# until free_fall
#   x, y  = start
#   at_rest = false

#   until at_rest
#     if y >= @matrix.size - 1
#       units -= 1
#       free_fall = true
#       break
#     end

#     at_rest, x, y = next_position(x, y)
#   end

#   units += 1
#   @matrix[y][x] = 'o'
# end


full = false

until full
  x, y  = @start
  at_rest = false

  until at_rest
    if @matrix[@start[1]][@start[0]] == 'o'
      units -= 1
      full = true
      break
    end

    at_rest, x, y = next_position(x, y)
  end

  units += 1
  @matrix[y][x] = 'o'

  add_boundary('left', max_y) if x == 0
  add_boundary('right', max_y) if x == @matrix.first.size - 1
end

@matrix.each { |i| puts i.join }

puts "\nunits at rest: #{units}"

file.close

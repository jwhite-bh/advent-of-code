file = File.open('inputs/2022_7.txt')

file_data = file.readlines.map(&:chomp)

visited_dirs = []
curr_dir = ''
dir_tree = Hash.new

while file_data.length > 0
  comm = file_data.shift
  if comm == '$ cd ..'
    curr_dir = visited_dirs.pop
  elsif /\$ cd (\w|\/)+/.match(comm)
    if visited_dirs.empty?
      curr_dir = comm.split(' ').last
      dir_tree[curr_dir] = 0
    else
      curr_dir = "#{visited_dirs.join('')}#{comm.split(' ').last}/"
    end

    visited_dirs.append(curr_dir)
  elsif comm == "$ ls"
    until file_data.empty? || file_data.first.start_with?("$")
      dir_con = file_data.shift.split(' ')
      if dir_con.first == 'dir'
        dir_tree["#{visited_dirs.join('')}#{dir_con.last}/"] = 0
      else
        visited_dirs.each { |dir| dir_tree[dir] += dir_con.first.to_i}
      end
    end
  end
end

puts "Total size of Directories under 100000: #{dir_tree.values.select { |val| val <= 100_000 }.sum}"

need_free = 30_000_000 - (70_000_000 - dir_tree['/'])

puts "Smallest delete: #{dir_tree.values.select { |val| val >= need_free }.min}"

file.close

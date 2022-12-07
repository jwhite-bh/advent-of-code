file = File.open('inputs/2022_6.txt')

file_data = file.read.split('')

file_data.each_with_index do |char, i|
  # First Puzzle
  # next if i < 3

  # last_chunk = file_data[i-3..i-1]

  # if !last_chunk.include?(char) && last_chunk.uniq.length == last_chunk.length
  #   puts "First Marker: #{i+1}"
  #   break
  # end

  # Second Puzzle
  next if i < 13

  last_chunk = file_data[i - 13..i - 1]

  if !last_chunk.include?(char) && last_chunk.uniq.length == last_chunk.length
    puts "First Marker: #{i + 1}"
    break
  end
end

file.close

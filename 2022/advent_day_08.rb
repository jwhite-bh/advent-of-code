def visible_vertical?(row, col_i, tree)
  row[0..col_i - 1].max < tree || row[col_i + 1, row.size].max < tree
end

def visible_horizontal?(col, row_i, tree)
  col[0..row_i - 1].max < tree || col[row_i + 1, col.size].max < tree
end

def visible?(row, col, row_i, col_i, tree)
  visible_vertical?(row, col_i, tree) || visible_horizontal?(col, row_i, tree)
end

def scenic_score(row, col, row_i, col_i, tree)
  left, right, up, down = 0, 0, 0, 0

  (col_i - 1).downto(0).each do |i|
    left += 1
    break if row[i] >= tree
  end

  (col_i + 1).upto(row.size - 1) do |i|
    right += 1
    break if row[i] >= tree
  end

  (row_i - 1).downto(0).each do |i|
    up += 1
    break if col[i] >= tree
  end

  (row_i + 1).upto(col.size - 1) do |i|
    down += 1
    break if col[i] >= tree
  end

  left * right * up * down
end

file = File.open('inputs/2022_8.txt')

file_data = file.readlines.map(&:chomp)

trees = []

file_data.each { |row| trees.append(row.scan(/\d/).map(&:to_i)) }

vis_trees = 0
best_score = 0

trees.each_with_index do |row, row_i|
  if row_i == 0 || row_i == trees.size - 1
    vis_trees += row.size
    next
  end
  row.each_with_index do |tree, col_i|
    if col_i == 0 || col_i == row.size - 1
      vis_trees += 1
    else
      col = trees.map { |r| r[col_i] }

      score = scenic_score(row, col, row_i, col_i, tree)
      best_score = score if score > best_score

      vis_trees += 1 if visible?(row, col, row_i, col_i, tree)
    end
  end


end

puts "Visible Trees: #{vis_trees}"
puts "Best Scenic Score: #{best_score}"

file.close

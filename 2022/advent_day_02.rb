file = File.open('inputs/2022_2.txt')

file_data = file.readlines.map(&:chomp)

rps = {
  'A' => { beat: ['C', 'Z'], score: 1 },
  'X' => { beat: ['C', 'Z'], score: 1 },
  'B' => { beat: ['A', 'X'], score: 2 },
  'Y' => { beat: ['A', 'X'], score: 2 },
  'C' => { beat: ['B', 'Y'], score: 3 },
  'Z' => { beat: ['B', 'Y'], score: 3 }
}

winning_plays = {
  'A' => 'C',
  'B' => 'A',
  'C' => 'B'
}

player_score = 0

file_data.each do |play|
  play = play.split(' ')

  # Puzzle One
  # if rps[play[0]][:beat].any? { |opp_play| opp_play == play[1] }
  #   player_score += rps[play[1]][:score]
  # elsif rps[play[1]][:beat].any? { |opp_play| opp_play == play[0] }
  #   player_score += 6 + rps[play[1]][:score]
  # else
  #   player_score += 3 + rps[play[1]][:score]
  # end

  # Puzzle Two
  if play[1] == 'X'
    player_score += rps[winning_plays[play[0]]][:score]
  elsif play[1] == 'Y'
    player_score += rps[play[0]][:score] + 3
  else
    player_score += rps[winning_plays.key(play[0])][:score] + 6
  end
end

puts "Score: #{player_score}"

file.close

class LineParser
  def is_game_start?(line)
    line.match?(/InitGame:/)
  end
end
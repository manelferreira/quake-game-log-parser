class LineParser
  def is_game_start?(line)
    line.match?(/InitGame:/)
  end

  def is_game_end?(line)
    line.match?(/ShutdownGame:/)
  end

  def kill?(line)
    line.match?(/Kill:/)
  end
end
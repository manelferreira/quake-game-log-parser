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

  def kill_data(line)
    line_match = line.scan(/: .*: (.*) killed (.*) by/)
    data_parts = line_match.first

    {
      "killer" => data_parts.first,
      "killed" => data_parts.last 
    }
  end

  def new_player?(line)
    line.match?(/ClientUserinfoChanged/)
  end

  def new_player_name(line)
    line_match = line.scan(/n\\(.*)\\t\\/)
    data_parts = line_match.first

    data_parts.first
  end
end
require 'line_parser'

class GameParser
  def parse(log_lines)
    games = []
    current_game = 0
    reading_game = false

    line_parser = LineParser.new
    
    log_lines.each do |line|
      if reading_game
        if (line_parser.is_game_end?(line))
          reading_game = false
        end
      elsif line_parser.is_game_start?(line)
        reading_game = true
        current_game += 1 
        games.push << create_game_data_structure(current_game)
      end
    end

    games
  end

  private
  def create_game_data_structure(game_number)
    {
      "game_#{game_number}" => {
        "total_kills" => 0,
        "players" => [],
        "kills" => {}
      }
    }
  end
end
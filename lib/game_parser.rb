require 'line_parser'

class GameParser
  def initialize
    @line_parser = LineParser.new
  end

  def parse(log_lines)
    games = []
    current_game_number = 0
    reading_game = false
    current_game = {}
    
    log_lines.each do |line|
      if reading_game
        if (@line_parser.is_game_end?(line))
          reading_game = false
        else
          parse_game(line, current_game, current_game_number)
        end
      elsif @line_parser.is_game_start?(line)
        reading_game = true
        current_game_number += 1 
        current_game = create_game_data_structure(current_game_number)
        games.push(current_game)
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

  def parse_game(line, current_game, current_game_number)
    game_id = "game_#{current_game_number}"

    if @line_parser.kill?(line)
      current_game[game_id]["total_kills"] += 1
    end

    current_game
  end
end
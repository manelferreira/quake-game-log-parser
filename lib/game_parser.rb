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

      kill_data = @line_parser.kill_data(line)

      if kill_data["killer"] == "<world>"
        if current_game[game_id]["kills"][kill_data["killed"]].nil?
          current_game[game_id]["kills"][kill_data["killed"]] = -1
        else
          current_game[game_id]["kills"][kill_data["killed"]] -= 1
        end

        return
      end
      
      if current_game[game_id]["kills"][kill_data["killer"]].nil?
        current_game[game_id]["kills"][kill_data["killer"]] = 1
      else
        current_game[game_id]["kills"][kill_data["killer"]] += 1
      end
    elsif @line_parser.new_player?(line)
      new_player_name = @line_parser.new_player_name(line)

      return if current_game[game_id]["players"].include?(new_player_name)

      current_game[game_id]["players"].push(new_player_name)
    end

    current_game
  end
end
require 'line_parser'
require 'game_record'

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
          parse_game(line, current_game)
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
    GameRecord.new(game_number)
  end

  def parse_game(line, current_game)
    if @line_parser.kill?(line)
      kill_data = @line_parser.kill_data(line)

      if kill_data["killer"] == "<world>"
        current_game.decrease_kill_score(kill_data["killed"])
        return
      end
      
      current_game.increase_kill_score(kill_data["killer"])
      
    elsif @line_parser.new_player?(line)
      new_player_name = @line_parser.new_player_name(line)
      current_game.add_player(new_player_name)
    end

    current_game
  end
end
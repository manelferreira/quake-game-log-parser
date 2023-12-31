require_relative 'line_parser'
require_relative 'game_record'

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
      handle_kill(line, current_game)
    elsif @line_parser.new_player?(line)
      handle_new_player(line, current_game)
    end

    current_game
  end

  def handle_kill(line, current_game)
    kill_data = @line_parser.kill_data(line)

    if kill_data["killer"] == "<world>"
      current_game.decrease_kill_score(kill_data["killed"])
    elsif kill_data["killer"] == kill_data["killed"]
      current_game.increase_total_kills
    else
      current_game.increase_kill_score(kill_data["killer"])
    end
  end

  def handle_new_player(line, current_game)
    new_player_name = @line_parser.new_player_name(line)
    current_game.add_player(new_player_name)
  end 
end
class GameRecord 
  def initialize(game_number)
    @game_id = "game_#{game_number}"
    @players = []
    @total_kills = 0
    @kills = {}
  end

  def add_player(player)
    return if @players.include?(player)
    @players.push(player)
  end

  def increase_total_kills
    @total_kills += 1
  end

  def increase_kill_score(player)
    @total_kills += 1

    if @kills[player].nil?
      @kills[player] = 1
    else
      @kills[player] += 1
    end
  end

  def decrease_kill_score(player)
    @total_kills += 1

    if @kills[player].nil?
      @kills[player] = -1
    else
      @kills[player] -= 1
    end
  end

  public
  def to_hash
    {
      "#{@game_id}" => {
        "total_kills" => @total_kills,
        "players" => @players,
        "kills" => @kills
      }
    }
  end
end
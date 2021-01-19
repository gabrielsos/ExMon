defmodule ExMon do
  alias ExMon.Player
  def createPlayer(name, moveAvg, moveRand, moveHeal) do
    Player.build(name, moveAvg, moveRand, moveHeal)
  end
end

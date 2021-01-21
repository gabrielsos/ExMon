defmodule ExMon.Game.Actions.Attack do
  alias ExMon.Game

  @moveAvgPower 18..25
  @moveRndPower 10..35

  def attackOpponent(opponent, move) do
    damage = calculatePower(move)

    opponent
    |> Game.fetchPlayer()
    |> Map.get(:life)
    |> calculateTotalLife(damage)
    |> updateOpponentLife(opponent)
  end

  defp updateOpponentLife(life, opponent) do
    opponent
    |> Game.fetchPlayer()
    |> Map.put(:life, life)
    |> updateGame(opponent)
  end

  defp updateGame(player, opponent) do
    Game.info()
    |> Map.put(opponent, player)
    |> Game.update()
  end

  defp calculateTotalLife(life, damage) when life - damage < 0, do: 0
  defp calculateTotalLife(life, damage), do: life - damage

  defp calculatePower(:moveAvg), do: Enum.random(@moveAvgPower)
  defp calculatePower(:moveRand), do: Enum.random(@moveRndPower)
end

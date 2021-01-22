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
    |> updateOpponentLife(opponent, damage)
  end

  defp updateOpponentLife(life, opponent, damage) do
    opponent
    |> Game.fetchPlayer()
    |> Map.put(:life, life)
    |> updateGame(opponent, damage)
  end

  defp updateGame(player, opponent, damage) do
    Game.info()
    |> Map.put(opponent, player)
    |> Game.update()

    Game.Status.printMoveMessage(opponent, :attack, damage)
  end

  defp calculateTotalLife(life, damage) when life - damage < 0, do: 0
  defp calculateTotalLife(life, damage), do: life - damage

  defp calculatePower(:moveAvg), do: Enum.random(@moveAvgPower)
  defp calculatePower(:moveRand), do: Enum.random(@moveRndPower)
end

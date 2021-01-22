defmodule ExMon.Game do
  alias ExMon.Player
  use Agent

  def start(computer, player) do
    initialValue = %{computer: computer, player: player, turn: :player, status: :started}
    Agent.start_link(fn -> initialValue end, name: __MODULE__)
  end

  def info do
    Agent.get(__MODULE__, & &1)
  end

  def update(state) do
    Agent.update(__MODULE__, fn _ -> updateGameStatus(state) end)
  end

  def player, do: Map.get(info(), :player)

  def turn, do: Map.get(info(), :turn)
  def fetchPlayer(player), do: Map.get(info(), player)

  defp updateGameStatus(
         %{player: %Player{life: playerLife}, computer: %Player{life: computerLife}} = state
       )
       when playerLife == 0 or computerLife == 0,
       do: Map.put(state, :status, :gameOver)

  defp updateGameStatus(state) do
    state
    |> Map.put(:status, :continue)
    |> updateTurn()
  end

  defp updateTurn(%{turn: :player} = state), do: Map.put(state, :turn, :computer)
  defp updateTurn(%{turn: :computer} = state), do: Map.put(state, :turn, :player)
end

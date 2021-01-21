defmodule ExMon.Game do
  use Agent

  def start(computer, player) do
    initialValue = %{computer: computer, player: player, turn: :player, status: :started}
    Agent.start_link(fn -> initialValue end, name: __MODULE__)
  end

  def info do
    Agent.get(__MODULE__, & &1)
  end

  def update(state) do
    Agent.update(__MODULE__, fn _ -> state end)
  end

  def player, do: Map.get(info(), :player)

  def turn, do: Map.get(info(), :turn)
  def fetchPlayer(player), do: Map.get(info(), player)
end

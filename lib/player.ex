defmodule ExMon.Player do
  @requiredKeys [:life, :moves, :name]
  @maxLife 100

  @enforce_keys @requiredKeys
  defstruct @requiredKeys

  def build(name, moveRand, moveAvg, moveHeal) do
    %ExMon.Player{
      life: @maxLife,
      moves: %{
        moveAvg: moveAvg,
        moveHeal: moveHeal,
        moveRand: moveRand
      },
      name: name
    }
  end
end

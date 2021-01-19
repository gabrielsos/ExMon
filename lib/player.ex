defmodule ExMon.Player do
  @requiredKeys [:life, :moveAvg, :moveHeal, :moveRand,  :name]
  @maxLife 100

  @enforce_keys @requiredKeys
  defstruct @requiredKeys

  def build(name, moveRand, moveAvg, moveHeal) do
    %ExMon.Player{
      life: @maxLife,
      moveAvg: moveAvg,
      moveHeal: moveHeal,
      moveRand: moveRand,
      name: name
    }
  end
end

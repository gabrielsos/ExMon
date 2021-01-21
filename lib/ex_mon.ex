defmodule ExMon do
  alias ExMon.{Game, Player}
  alias ExMon.Game.{Status, Actions}

  @computerName "Robot"
  def createPlayer(name, moveAvg, moveRand, moveHeal) do
    Player.build(name, moveAvg, moveRand, moveHeal)
  end

  def startGame(player) do
    @computerName
    |> createPlayer(:punch, :kick, :heal)
    |> Game.start(player)

    Status.printRoundMessage()
  end

  def makeMove(move) do
    move
    |> Actions.fetchMove()
    |> doMove()
  end

  defp doMove({:error, move}), do: Status.printWrongMoveMessage(move)
  defp doMove({:ok, move}) do
    case move do
      :moveHeal -> "realiza cura"
      move -> Actions.attack(move)
    end
  end
end

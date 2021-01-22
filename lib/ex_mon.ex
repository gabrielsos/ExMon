defmodule ExMon do
  alias ExMon.{Game, Player}
  alias ExMon.Game.{Status, Actions}

  @computerName "Robot"
  @computerMoves [:moveAvg, :moveRand, :moveHeal]
  def createPlayer(name, moveAvg, moveRand, moveHeal) do
    Player.build(name, moveAvg, moveRand, moveHeal)
  end

  def startGame(player) do
    @computerName
    |> createPlayer(:punch, :kick, :heal)
    |> Game.start(player)

    Status.printRoundMessage(Game.info())
  end

  def makeMove(move) do
    Game.info()
    |> Map.get(:status)
    |> handleStatus(move)

    computerMove(Game.info)
  end

  defp handleStatus(:gameOver, _move), do: Status.printRoundMessage(Game.info())

  defp handleStatus(_other, move) do
    move
    |> Actions.fetchMove()
    |> doMove()
  end

  defp doMove({:error, move}), do: Status.printWrongMoveMessage(move)
  defp doMove({:ok, move}) do
    case move do
      :moveHeal -> Actions.heal()
      move -> Actions.attack(move)
    end

    Status.printRoundMessage(Game.info())
  end

  defp computerMove(%{turn: :computer, status: :continue}) do
    move = {:ok, Enum.random(@computerMoves)}
    doMove(move)
  end

  defp computerMove(_), do: :ok
end

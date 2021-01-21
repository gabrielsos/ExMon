defmodule ExMon.Game.Status do
  alias ExMon.Game
  def printRoundMessage() do
    IO.puts("\n===== The game is started =====\n")
    IO.inspect(Game.info())
    IO.puts("----------------------")
  end

  def printWrongMoveMessage(move) do
    IO.puts("\n===== Invalid move: #{move} =====\n")
  end
end

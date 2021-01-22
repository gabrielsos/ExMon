defmodule ExMon.Game.Status do
  def printRoundMessage(%{status: :started} = info) do
    IO.puts("\n===== The game is started =====\n")
    IO.inspect(info)
    IO.puts("----------------------")
  end

  def printRoundMessage(%{status: :continue, turn: player} = info) do
    IO.puts("\n===== It's #{player} turn =====\n")
    IO.inspect(info)
    IO.puts("----------------------")
  end

  def printRoundMessage(%{status: :gameOver} = info) do
    IO.puts("\n===== The game is over =====\n")
    IO.inspect(info)
    IO.puts("----------------------")
  end

  def printWrongMoveMessage(move) do
    IO.puts("\n===== Invalid move: #{move} =====\n")
  end

  def printMoveMessage(:player, :attack, damage) do
    IO.puts("\n======= The Computer attacked the player dealing #{damage} damage. ======= \n")
  end

  def printMoveMessage(:computer, :attack, damage) do
    IO.puts("\n======= The Player attacked the computer dealing #{damage} damage. ======= \n")
  end
end

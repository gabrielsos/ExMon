defmodule ExMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Player

  describe "createPlayer/4" do
    test "returns a player" do
      expectedResponse = %Player{
        life: 100,
        moves: %{moveAvg: :soco, moveHeal: :cura, moveRand: :chute},
        name: "Gabriel"
      }

      assert ExMon.createPlayer("Gabriel", :chute, :soco, :cura) == expectedResponse
    end
  end

  describe "startGame/1" do
    test "when the game start return a message" do
      player = Player.build("Gabriel", :chute, :soco, :cura)

      messages =
        capture_io(fn ->
          assert ExMon.startGame(player) == :ok
        end)

      assert messages =~ "The game is started"
      assert messages =~ "status: :started"
      assert messages =~ "turn: :player"
    end
  end

  describe "makeMove/1" do
    setup do
      player = Player.build("Gabriel", :chute, :soco, :cura)
        capture_io(fn ->
          ExMon.startGame(player)
        end)

        :ok
    end

    test "when the move is valid do the move and the computer makes a move" do
      messages = capture_io(fn ->
        ExMon.makeMove(:chute)
      end)

      assert messages =~ "The Player attacked the computer"
      assert messages =~ "It's computer turn"
      assert messages =~ "It's player turn"
      assert messages =~ "status: :continue"
    end

    test "when the move is invalid returns an error message" do
      messages = capture_io(fn ->
        ExMon.makeMove(:invalidMove)
      end)

      assert messages =~ "Invalid move: invalidMove"
    end
  end
end

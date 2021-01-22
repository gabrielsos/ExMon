defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Player, Game}

  describe "start/2" do
    test "start the game state" do
      player = Player.build("Gabriel", :chute, :soco, :cura)
      computer = Player.build("Gabriel", :chute, :soco, :cura)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.build("Gabriel", :chute, :soco, :cura)
      computer = Player.build("Robot", :chute, :soco, :cura)

      Game.start(computer, player)

      expectedResponse = %{
        computer: %Player{
          life: 100,
          moves: %{moveAvg: :soco, moveHeal: :cura, moveRand: :chute},
          name: "Robot"
        },
        player: %Player{
          life: 100,
          moves: %{moveAvg: :soco, moveHeal: :cura, moveRand: :chute},
          name: "Gabriel"
        },
        status: :started,
        turn: :player
      }

      assert Game.info() == expectedResponse
    end
  end

  describe "update/1" do
    test "returns the game state updated" do
      player = Player.build("Gabriel", :chute, :soco, :cura)
      computer = Player.build("Robot", :chute, :soco, :cura)

      Game.start(computer, player)

      expectedResponse = %{
        computer: %Player{
          life: 100,
          moves: %{moveAvg: :soco, moveHeal: :cura, moveRand: :chute},
          name: "Robot"
        },
        player: %Player{
          life: 100,
          moves: %{moveAvg: :soco, moveHeal: :cura, moveRand: :chute},
          name: "Gabriel"
        },
        status: :started,
        turn: :player
      }

      assert Game.info() == expectedResponse

      newState = %{
        computer: %Player{
          life: 85,
          moves: %{moveAvg: :soco, moveHeal: :cura, moveRand: :chute},
          name: "Robot"
        },
        player: %Player{
          life: 50,
          moves: %{moveAvg: :soco, moveHeal: :cura, moveRand: :chute},
          name: "Gabriel"
        },
        status: :started,
        turn: :player
      }

      Game.update(newState)

      expectedResponse = %{newState | turn: :computer, status: :continue}

      assert Game.info() == expectedResponse
    end
  end

  describe "turn/0" do
    test "returns the actual turn" do
      player = Player.build("Gabriel", :chute, :soco, :cura)
      computer = Player.build("Robot", :chute, :soco, :cura)

      Game.start(computer, player)

      expectedResponse = :player

      assert Game.turn() == expectedResponse
    end
  end

  describe "player/0" do
    test "returns the actual turn" do
      player = Player.build("Gabriel", :chute, :soco, :cura)
      computer = Player.build("Robot", :chute, :soco, :cura)

      Game.start(computer, player)

      expectedResponse = %ExMon.Player{
        life: 100,
        moves: %{moveAvg: :soco, moveHeal: :cura, moveRand: :chute},
        name: "Gabriel"
      }

      assert Game.player() == expectedResponse
    end
  end
end

require 'rspec'
require 'game'

describe Game do
  subject(:game) { Game.new(4) }

  describe "#initialize" do
    it "sets up players correctly" do
      expect(game.players.length).to eq(4)
    end

    it "sets up deck correctly" do
      expect(game.deck).to be_instance_of(Deck)
    end
  end

  describe "#deal" do
    it "add 5 cards in hand of each player" do
      game.deal
      game.players.each { |player| expect(player.cards.length).to eq(5)} 
    end
  end

  describe "#over?" do
    it "return true  when only 1 player is not folded" do
      game.players[0].fold
      game.players[1].fold
      game.players[2].fold

      expect(game.over?).to be true 
    end

    it "return false when more than 1 plyer is not folded" do 
      game.players[0].fold

      expect(game.over?).to be false 
    end
  end
end
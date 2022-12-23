require 'rspec'
require 'player'

describe Player do
  subject(:player) { Player.new }

  describe "#initialize" do
    it "sets the amount of put to zero"  do
      expect(player.pot).to eq(0)
    end

    it "sets hand correctly" do
      expect(player.hand).to be_instance_of(Hand)
    end

    it "sets folded to false " do 
      expect(player.folded).to be(false)
    end
  end

  describe "#fold" do
    it "sets folded to true" do
      player.fold 
      expect(player.folded).to be(true)
    end

    it "empty the hand cards" do 
      player.fold
      expect(player.cards).to match_array([])
    end
  end

  describe "#increase_pot" do
    it "should increase pot amount" do
      player.increase_pot(5)
      expect(player.pot).to eq(5)
    end
  end
end


require 'rspec'
require 'card'

describe Card do
  subject(:card) { Card.new("hearts", "10") }

  describe "#initialize" do
    it "sets up correctly" do
      expect(card.suit).to eq("hearts")
      expect(card.rank).to eq("10")
    end
  end

  describe "<=>" do
    it "returns 0 if cards are the same" do
      expect(Card.new("diamonds", "5") <=> Card.new("diamonds", "5")).to eq(0)
    end

    it "returns 1 when card has lower rank" do
      expect(Card.new("diamonds", "5") <=> Card.new("diamonds", "10")).to eq(1)
    end

    it "returns -1 when card has higher rank" do
      expect(Card.new("diamonds", "10") <=> Card.new("diamonds", "5")).to eq(-1)
    end

    it "return 1 when card has higher suit" do
      expect(Card.new("hearts", "10") <=> Card.new("diamonds", "10")).to eq(1)
    end

    it "return -1 when card has lower suit" do
      expect(Card.new("diamonds", "10") <=> Card.new("hearts", "10")).to eq(-1)
    end
  end
end


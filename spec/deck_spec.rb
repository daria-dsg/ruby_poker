require 'rspec'
require 'deck'

describe Deck do
  subject(:deck) { Deck.new }
  subject(:all_cards) { deck.all_cards }
  
  describe ":all_cards" do
    it "contains 52 cards" do
      expect(all_cards.count).to eq(52)
    end

    it "does not contain dublicate" do
      expect(
        all_cards.map { |card| [card.suit, card.rank] }.uniq.count
      ).to eq (all_cards.count)
    end
  end

  describe "#take" do
    it "removes the first card from deck" do
      taken_card = all_cards[0]
      card = deck.take
   
      expect(all_cards.count).to eq(51)
      expect(all_cards).to_not include(taken_card)
    end

    it "returns a card " do
      card = deck.take
      expect(card).to be_instance_of(Card)
    end
  end

  describe "#add" do 
    it "add cards to deck" do  
       cards = [deck.take, deck.take, deck.take]
       deck.add(cards)
       cards.each  { |card| expect(deck.all_cards).to include(card) }
    end
  end
end
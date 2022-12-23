require 'rspec'
require 'hand'

describe Hand do
  subject(:hand) { Hand.new }

  before(:each) do 
    hand.add(Card.new("spades", "10"))
    hand.add(Card.new("diamonds", "10"))
    hand.add(Card.new("hearts", "8"))
    hand.add(Card.new("spades", "ace"))
    hand.add(Card.new("spades", "8"))
  end

  describe "#add" do
    it "puts one card to hand " do
      expect(hand.cards.find { |card| card.suit == "spades" && card.rank == "8" }).not_to be_nil
    end

    context "when already 5 cards" do
      it "raise en exception" do
        expect { hand.add(Card.new("hearts", "2")) }.to raise_error(RuntimeError)
      end
    end
  end

  describe "#discard" do 
    it "should eliminate cards from hand" do
      take_cards = hand.cards[0 .. 1]

      hand.discard(take_cards)
      expect(hand.cards).to_not include(*take_cards)
    end
  end

  describe "poker_hands" do
    let(:high_card) { Hand.new}
    let(:pair) { Hand.new }
    let(:two_pair) { Hand.new }
    let(:three_of_a_king) { Hand.new }
    let(:straight) { Hand.new }
    let(:flush) { Hand.new }
    let(:full_house) { Hand.new }
    let(:four_of_a_king) { Hand.new }
    let(:straight_flush) { Hand.new }
    let(:royal_flush) { Hand.new }

    let(:other_hand) { Hand.new}

    before(:each) do
      [ Card.new("spades", "queen"),
        Card.new("spades", "10"),
        Card.new("hearts", "7"),
        Card.new("diamonds", "6"),
        Card.new("hearts", "4")
      ].each { |card| high_card.add(card) }

      [ Card.new("spades", "ace"),
        Card.new("spades", "ace"),
        Card.new("hearts", "queen"),
        Card.new("diamonds", "ACE"),
        Card.new("hearts", "10")
      ].each { |card| pair.add(card) }

      [ Card.new("spades", "5"),
        Card.new("diamonds", "5"),
        Card.new("hearts", "3"),
        Card.new("diamonds", "3"),
        Card.new("hearts", "jack")
      ].each { |card| two_pair.add(card) }

      [ Card.new("spades", "king"),
        Card.new("clubs", "king"),
        Card.new("hearts", "king"),
        Card.new("diamonds", "queen"),
        Card.new("hearts", "ten")
      ].each {|card| three_of_a_king.add(card)}

      [ Card.new("spades", "3"),
        Card.new("spades", "4"),
        Card.new("hearts", "5"),
        Card.new("diamonds", "6"),
        Card.new("hearts", "7")
      ].each {|card| straight.add(card)}

      [ Card.new("spades", "4"),
        Card.new("spades", "8"),
        Card.new("spades", "6"),
        Card.new("spades", "7"),
        Card.new("spades", "2")
      ].each {|card| flush.add(card)}

      [ Card.new("spades", "queen"),
        Card.new("hearts", "queen"),
        Card.new("clubs", "queen"),
        Card.new("spades", "6"),
        Card.new("hearts", "6")
      ].each { |card| full_house.add(card) }

      [ Card.new("spades", "queen"),
        Card.new("hearts", "queen"),
        Card.new("clubs", "queen"),
        Card.new("diamonds", "queen"),
        Card.new("hearts", "6")
      ].each { |card| four_of_a_king.add(card) }

      [ Card.new("spades", "3"),
        Card.new("spades", "4"),
        Card.new("spades", "5"),
        Card.new("spades", "6"),
        Card.new("spades", "7")
      ].each { |card| straight_flush.add(card) }

      [Card.new("spades", "10"),
        Card.new("spades", "jack"),
        Card.new("spades", "queen"),
        Card.new("spades", "king"),
        Card.new("spades", "ace")
      ].each { |card| royal_flush.add(card) }
    end

    let(:hands) do
      [
        royal_flush,
        straight_flush,
        four_of_a_king,
        full_house,
        flush,
        straight,
        three_of_a_king,
        two_pair,
        pair,
        high_card
      ]
    end

    let(:poker_hands) do
      [
        :royal_flush,
        :straight_flush,
        :four_of_a_king,
        :full_house,
        :flush,
        :straight,
        :three_of_a_king,
        :two_pair,
        :pair,
        :high_card
      ]
    end

    describe "#pairs" do 
      it "should return the number of pairs with the same rank" do
        expect(hand.pairs).to eq (2)
      end
    end

    describe "#count_ranks" do 
      it "should return the number of time the rank is appeared" do
        expect(hand.count_ranks("10")).to eq(2) 
      end
    end

    describe "pair?" do
      it "returns true when one pair" do
        expect(pair.pair?).to be true
      end
    end

    describe "two_pair?" do
      it "returns true when two pair" do
        expect(two_pair.two_pair?).to be true
      end
    end

    describe "three_of_a_king?" do
      it "returns true when three of a king" do
        expect(three_of_a_king.three_of_a_king?).to be true
      end
    end
  
    describe "straight?" do
      it "returns true when straight" do
        expect(straight.straight?).to be true
      end
    end
  
    describe "flush?" do
      it "returns true when flush" do
        expect(flush.flush?).to be true
      end
    end
  
    describe "full_house?" do
      it "returns true when full house" do
        expect(full_house.full_house?).to be true
      end
    end
  
    describe "four_of_a_king?" do
      it "returns true when four_of_a_king" do
        expect(four_of_a_king.four_of_a_king?).to be true
      end
    end
  
    describe "straight_flush?" do
      it "returns true when straight_flush" do
        expect(straight_flush.straight_flush?).to be true
      end
    end
  
    describe "royal_flush?" do
      it "returns true when royal_flush" do
        expect(royal_flush.royal_flush?).to be true
      end
    end
  
    describe "rank" do
      it "should return the correct rank" do
         hands.each_with_index do |hand,i|
            expect(hand.rank).to eq(poker_hands[i])
         end
      end
    end

    describe "<=>" do 
      it "returns 1 if hand has the higher rank" do
        expect(flush <=> straight).to eq(1)
      end

      it "returns -1 if hand has the lowest rank" do
        expect(straight <=> flush).to eq(-1)
      end

      context "when a tie" do
        it "return 1 if hand has the highest rank card" do
          [ Card.new("spades", "6"),
            Card.new("spades", "6"),
            Card.new("hearts", "6"),
            Card.new("diamonds", "6"),
            Card.new("hearts", "6")
          ].each { |card| other_hand.add(card) } 

          expect(high_card <=> other_hand).to eq(-1)
        end

        it "return -1 if hands are equal and hand has the lowest rank card" do
          [ Card.new("spades", "5"),
            Card.new("diamonds", "5"),
            Card.new("hearts", "3"),
            Card.new("diamonds", "3"),
            Card.new("hearts", "queen")
          ].each { |card| other_hand.add(card) } 

          expect(two_pair <=> other_hand).to eq(1)
        end
      end
    end
  end
end 




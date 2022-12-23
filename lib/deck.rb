require_relative "card.rb"

class Deck
  attr_reader :all_cards
  
  def initialize
    @all_cards = []
    populate
    shuffle
  end

  def populate
    Card::SUITS.each do |suit|
      Card::RANKS.each do |rank|
        @all_cards << Card.new(suit, rank)
      end
    end
  end

  def shuffle
    @all_cards.shuffle!
  end

  # deal one card from deck 
  def take
    card = @all_cards.shift
    card
  end

  def add(cards)
    cards.each { |card| all_cards << card }
  end
end




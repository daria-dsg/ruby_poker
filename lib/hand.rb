require_relative './poker_hands'

class Hand
  include PokerHands

  attr_accessor :cards
  
  def initialize
    @cards = []
  end

  def add(card)
    if  @cards.length == 5
      raise "players already has 5 cards" 
    else
      @cards << card
    end
  end

  def show
    @cards.each_with_index { |card, i| puts "Card number #{i + 1}: #{card.suit} #{card.rank}" }
  end

  def discard(cards_to_reject)
    cards.reject! { |card| cards_to_reject.include?(card)}
  end

  def sort_cards
    @cards.sort!
  end
end
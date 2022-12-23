class Card
  include Comparable

  SUITS = ["clubs", "diamonds", "hearts", "spades"]
  RANKS = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "jack", "queen", "king", "ace"]
  attr_reader :suit, :rank
  
  def initialize(suit, rank)
    @suit, @rank = suit, rank
  end

  def ==(other_card)
    (self.suit == other_card.suit) && (self.rank == other_card.rank)
  end

  def rank_index
    RANKS.reverse.find_index(self.rank)
  end

  def <=>(other_card)
     if self == other_card
        0 
     elsif self.rank != other_card.rank 
        self.rank_index <=> other_card.rank_index
     elsif self.suit != other_card.suit
        SUITS.find_index(self.suit) <=> SUITS.find_index(other_card.suit)
     end
  end
end


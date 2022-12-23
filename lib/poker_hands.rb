module PokerHands
  POKER_HANDS = [
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

  def rank
    POKER_HANDS.each do |rank|
      return rank if self.send("#{rank}?")
    end
  end

  def <=>(other_hand)
    if self.rank != other_hand.rank
      POKER_HANDS.reverse.find_index(self.rank) <=> POKER_HANDS.reverse.find_index(other_hand.rank)
    else
      tie_breaker(other_hand)
    end
  end

  def tie_breaker(other_hand)
    self.cards.each_with_index do |card1, i1|
      other_hand.cards.each_with_index do |card2, i2|
        next unless i1 != i2
        
        if card1 > card2 
          return 1
        elsif card1 < card2
          return -1
        else  
         next
       end

      end
    end
    0
  end

  def royal_flush?
    royal = ["10", "jack", "queen", "king", "ace"]
    flush? && 
       cards.all? { |card| royal.include?(card.rank) }
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_king?
    @cards.any? { |card| count_ranks(card.rank) == 4 }
  end

  def full_house?
    three_of_a_king? && pair?
  end

  def flush?
    cards.map(&:suit).uniq.count == 1
  end

  def straight?
    cards.each_cons(2).all? { |card1, card2| card1.rank_index == card2.rank_index + 1}
  end

  def three_of_a_king?
    @cards.any? { |card| count_ranks(card.rank) == 3 }
  end

  def two_pair?
    pairs == 2
  end

  def pair?
    pairs == 1
  end

  def high_card?
    true
  end

  def pairs
    pair = 0
    cards.map(&:rank).uniq.each do |rank|
      pair += 1 if count_ranks(rank) == 2
    end
    pair
  end

  def count_ranks(value)
    cards.select {|card| card.rank == value}.count
  end
end
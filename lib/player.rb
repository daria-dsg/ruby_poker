require_relative 'hand'

class Player
  include Comparable

  attr_reader :hand, :folded, :pot
  
  COMMAND = ["f", "s", "r"]
  
  def initialize
    @hand, @pot, @folded = Hand.new, 0, false
  end

  # access cards from the hand
  def cards
    self.hand.cards
  end

  def fold
    @folded = true
    hand.cards = []
  end

  def folded?
    @folded
  end

  def increase_pot(sum)
    @pot += sum
  end

  def prompt_bet
    puts "Place your bet or fold. f - for fold, s - for see, r - for raise"
    input = gets.chomp
    raise "Command is not valid" unless COMMAND.include?(input)
    input
  end

  def prompt_raise
    puts "Your bet is "
    gets.chomp.to_i
  end

  def discard?
    puts "Do you want to discard cards? y - for yes, n - for no"
    gets.chomp == "y" ?  true : false
  end

  def prompt_cards
    puts "Which card do you want to discard?"
    idx_cards = gets.chomp.split(" ").map(&:to_i)
    raise "you can not discard more than 3 cards" if idx_cards.length > 3
    idx_cards.map {|num| hand.cards[num - 1]}
  end

  def <=>(other_player)
    self.hand <=> other_player.hand
  end

  private

  attr_writer :pot
end
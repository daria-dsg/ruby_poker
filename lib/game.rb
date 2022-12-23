require_relative 'deck'
require_relative 'player'

class Game
  attr_reader :players, :deck

  def initialize(num)
    @players, @deck = [], Deck.new
    add_players(num)
    deal
  end

  def add_players(num)
    num.times { @players << Player.new }
  end

  # deal up to 5 cards
  def deal
    @players.each do |player|
      until player.cards.length == 5
        player.hand.add(deck.take)
      end

      player.hand.sort_cards
    end
  end

  def total_pot
    count = 0 
    @players.each { |player| count += player.pot}
    count 
  end

  def bet
    @players.each_with_index do |player,i|
      next if player.folded
      system "clear"
      puts "It is a turn of a player number #{i + 1}"
      puts "Current bet is #{total_pot}"

      begin
        case player.prompt_bet
        when "f"
          deck.add(player.cards)
          deck.shuffle
          player.fold
          puts "Player number #{i + 1} will no longer play"
          sleep 0.75
        when "r"
          bet = player.prompt_raise
          raise "Bet is lower or equal to pot" if bet <= total_pot
          player.increase_pot(bet)
        when "s"
          raise "You can not see the zero bet" if total_pot == 0
          player.increase_pot(total_pot)
        end
      rescue RuntimeError => e
        puts "#{e.message}. Please try again"
        sleep 0.75
        retry
      end
    end
  end

  def drawing
    @players.each_with_index do |player,i|
      next if player.folded
      system "clear" 
      puts "It is a turn of a player number #{i + 1}"

      begin 
        next unless player.discard?
        player.hand.show
        cards_to_reject = player.prompt_cards
        player.hand.discard(cards_to_reject)
      rescue RuntimeError => e
        puts "#{e.message}. Please try again"
        sleep 0.75
        retry
      end
    end

    deal
  end

  def showdown
    @players.each_with_index do |player,i|
      next if player.folded
      puts " Cards of player number #{i + 1}"
      player.hand.show
    end
  end

  def over?
    @players.count { |player| !player.folded? } == 1
  end

  def play
    bet
    drawing
    bet
    round_over if over?
    showdown
    end_round
  end

  def winner
    @players.reject(&:folded).sort.last
  end

  def round_over
    unfolded = players.find {|player| !player.folded?}
    puts "The player number #{players.index(unfolded)} is one who did not fold!"
    puts "He won #{total_pot}"
    return
  end

  def end_round
    puts "The player number #{players.index(winner)} has the strongest hand!"
    puts "He won #{total_pot}"
  end
end
# frozen_string_literal: true

class Interface
  attr_reader :game

  def initialize
    @game = Game.new(name)
  end

  def name
    puts 'Enter your name'
    gets.chomp
  end

  def start
    @game.new_game
    show_info
    round
  end

  def round
    check_cards_amount
    user_move
    round
  end

  def show_info
    puts '....----==NEW GAME==----....'
    puts "Dealer / #{@game.user.name} score: #{@game.dealer.score} / #{@game.user.score}"
    puts "Bets made: #{@game.bank.account}$"
    puts "#{@game.user.name} #{@game.user.bank.account}$ | Dealer #{@game.dealer.bank.account}$"
    puts "Your cards: #{@game.user.show_cards}"
    puts "Dealer's cards: #{@game.dealer.hide_cards}"
  end

  def user_move
    puts 'Enter 1 to skip a move.' unless @game.user_skip == true
    puts 'Enter 2 to add a card.' unless @game.user.cards_max?
    puts 'Enter 3 to open cards.'
    choice = gets.chomp
    case choice
    when '1'
      raise "You can't skip a move more than once." if @game.user_skip == true
      @game.user_skip = true
      change_player(@game.user)
    when '2'
      raise 'You already have 3 cards' if @game.user.cards_max?
      add_card(@game.user)
    when '3'
      open_cards
    end
  rescue RuntimeError => e
    puts e.inspect
    retry
  end

  def change_player(player)
    check_cards_amount
    if player.class == User
      if @game.dealer.move(@game.deck)
        puts '1 card was handeled to Dealer.'
      else puts 'Dealer skipped a move.'
      end
    end
    user_move if player.class == Dealer
  end

  def add_card(player)
    player.handle(@game.deck)
    puts "1 card handeled to #{player.name}"
    puts "Your cards: #{player.show_cards}" if player.class == User
    puts "Dealer's cards: #{player.hide_cards}" if player.class == Dealer
    check_cards_amount
    change_player(player)
  end

  def check_cards_amount
    if @game.user.cards_max? && @game.dealer.cards_max?
      puts "\nBoth players have 3 cards in hands. Open cards."
      open_cards
    end
  end

  def open_cards
    puts "You have #{@game.user.show_cards}, #{@game.user.check_points} points. \n Dealer has #{@game.dealer.show_cards}, #{@game.dealer.check_points} points."
    results
  end

  def results
    if @game.winner
      @game.stakes_to_winner(@game.winner)
      puts "#{@game.winner.name} wins. The stakes go to #{@game.winner.name}."
      end_of_game if @game.bank_min?
    else
      @game.return_stakes
      puts 'The game ended in a tie. The stakes return to the players.'
    end
    puts 'New game? Enter 1 for Yes, 2 for No.'
    start if gets.chomp == '1'
    exit if gets.chomp == '2'
  end

  def end_of_game
    puts "End of game. Dealer score: #{@game.dealer.score}, #{@game.user.name} score: #{@game.user.score}."
    exit
  end
end

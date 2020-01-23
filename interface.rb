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
    check_cards_amount
    user_move
  end

  def show_info
    puts '....----==NEW GAME==----....'
    puts "Dealer / #{@game.user.name} score: #{@game.dealer.score} / #{@game.user.score}"
    puts "Bets made: #{@game.bank.account}$"
    puts "#{@game.user.name} #{@game.user.bank.account}$ | Dealer #{@game.dealer.bank.account}$"
    puts "Your cards: #{@game.user.show_cards}"
    puts "Dealer's cards: #{@game.dealer.hide_cards}"
  end

  def info_3cards
    puts "\nBoth players have 3 cards in hands. Open cards."
  end

  def user_move
    # if skip was - no skip
    # if 3 cards - no add
    puts 'Enter 1 to skip a move, 2 to add a card, 3 to open cards.'
    choice = gets.chomp
    case choice
    when '1'
      change_player(@game.user)
    when '2'
      add_card(@game.user)
    when '3'
      open_cards
    end
  end

  def change_player(player)
    # TODO: ask for new game if
    dealer_move if player.class == User
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

  def dealer_move
    check_cards_amount
    add_card(@game.dealer) if @game.dealer.check_score < 17
    change_player(@game.dealer) if @game.dealer.check_score >= 17
  end

  def check_cards_amount
    if @game.dealer.hand.size == 3 && @game.user.hand.size == 3
      info_3cards
      open_cards
    end
  end

  def open_cards
    puts "You have #{@game.user.show_cards}, #{@game.user.check_score} score. \n Dealer has #{@game.dealer.show_cards}, #{@game.dealer.check_score} score."
    winner
  end

  def winner
    if (@game.dealer.check_score < @game.user.check_score) && (@game.dealer.check_score <= 21)
      puts "#{@game.user.name} wins. The stakes go to #{@game.user.name}."
      @game.user.bank.credit(20)
      @game.bank.debit(20)
      @game.user.score += 1
    elsif (@game.user.check_score < @game.dealer.check_score) && (@game.user.check_score <= 21)
      puts "#{@game.dealer.name} wins. The stakes go to #{@game.dealer.name}."
      @game.dealer.bank.credit(20)
      @game.bank.debit(20)
      @game.dealer.score += 1
    else
      puts 'The game ended in a tie. The stakes return to the players.'
      @game.user.bank.credit(10)
      @game.dealer.bank.credit(10)
      @game.bank.debit(20)
    end
    puts 'New game? Enter 1 for Yes, 2 for No.'
    start if gets.chomp == '1'
    exit if gets.chomp == '2'
  end
end

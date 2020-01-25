# frozen_string_literal: true

class Game
  attr_accessor :user_skip
  attr_reader :deck, :bank, :user, :dealer

  def initialize(name)
    @user = User.new(name)
    @dealer = Dealer.new
    @bank = Bank.new(0)
  end

  def new_game
    bet
    @user.hand = []
    @dealer.hand = []
    @user_skip = false
    @deck = Deck.new
    @user.handle(@deck, 2)
    @dealer.handle(@deck, 2)
  end

  def winner
    if (@dealer.check_points == @user.check_points) || (@user.check_points > 21 && @dealer.check_points > 21)
      nil
    elsif @dealer.check_points > 21
      @user
    elsif @user.check_points > 21
      @dealer
    elsif @dealer.check_points < @user.check_points
      @user
    elsif @dealer.check_points > @user.check_points
      @dealer
    end
  end

  def return_stakes
    @bank.debit(20)
    @dealer.bank.credit(10)
    @user.bank.credit(10)
  end

  def stakes_to_winner(winner)
    winner.bank.credit(20)
    @bank.debit(20) unless @bank.account < 20
    winner.score += 1
  end

  def bank_min?
    @dealer.bank.account < 10 || @user.bank.account < 10
  end

  protected

  def bet
    @user.bank.debit(10)
    @dealer.bank.debit(10)
    @bank.credit(20)
  end
end

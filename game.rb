# frozen_string_literal: true

class Game
  attr_accessor :user_skip
  attr_reader :deck, :bank, :user, :dealer
  STAKE = 10
  BET = STAKE * 2

  def initialize(name)
    @user = User.new(name)
    @dealer = Dealer.new
    @bank = Bank.new
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
    if (@dealer.points == @user.points) || (@user.exceed_limit? && @dealer.exceed_limit?)
      nil
    elsif @dealer.exceed_limit?
      @user
    elsif @user.exceed_limit?
      @dealer
    else
      [@user, @dealer].max_by(&:points)
      # [@user, @dealer].max_by { |player| player.points }
      # @dealer.points > @user.points ? @dealer : @user
    end
  end

  def return_stakes
    @bank.debit(BET)
    @dealer.bank.credit(STAKE)
    @user.bank.credit(STAKE)
  end

  def stakes_to_winner(winner)
    winner.bank.credit(BET)
    @bank.debit(BET) unless @bank.balance < BET
    winner.score += 1
  end

  def bank_min?
    @dealer.bank.balance < STAKE || @user.bank.balance < STAKE
  end

  protected

  def bet
    @user.bank.debit(STAKE)
    @dealer.bank.debit(STAKE)
    @bank.credit(BET)
  end
end

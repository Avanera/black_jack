# frozen_string_literal: true

class Game
  attr_accessor :deck, :bank, :user, :dealer

  def initialize(name)
    @user = User.new(name)
    @dealer = Dealer.new
    @bank = Bank.new(0)
  end

  def new_game
    bet
    @user.hand = []
    @dealer.hand = []
    @deck = Deck.new
    @user.handle(@deck, 2)
    @dealer.handle(@deck, 2)
  end

  def bet
    @user.bank.debit(10)
    @dealer.bank.debit(10)
    @bank.credit(20)
  end
end

# frozen_string_literal: true

class Game
  attr_accessor :deck, :bank

  def initialize
    puts 'Enter your name'
    @@user = User.new(gets.chomp)
    @@dealer = Dealer.new
    @bank = 0
  end

  def self.deck
    @@deck
  end

  def self.dealer
    @@dealer
  end

  def self.user
    @@user
  end

  def start
    puts "Game started. Player1: #{@@user.name}, Player2: #{@@dealer.name}"
    @@user.check_bank
    @@dealer.check_bank
    @@deck = Deck.new
    @@user.handle(2)
    @@dealer.handle(2)
    bet
    @@user.move
  end

  def bet
    @@user.bank -= 10
    @@dealer.bank -= 10
    self.bank += 20
    puts "\nBets placed. #{self.bank} in game's bank."
  end
end

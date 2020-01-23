# frozen_string_literal: true

class Player
  attr_accessor :bank, :hand, :score
  attr_reader :name

  def initialize(name = 'Dealer')
    @name = name
    @bank = Bank.new(100)
    @hand = []
    @score = 0
  end

  def handle(deck, number = 1)
    number.times { @hand << deck.cards.shift }
  end

  def check_score
    s = 0
    @hand.each { |card| s += card.value }
    s
  end

  def show_cards
    @hand.map(&:output_card).join(' ')
  end

  def hide_cards
    @hand.map { |_card| '*' }.join(' ')
  end
end

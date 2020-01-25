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

  def check_points
    s = 0
    @hand.each { |card| s += card.value_of_rank(card.rank) }
    s -= 10 if s > 21 && include_a?
    s
  end

  def include_a?
    a = false
    @hand.each { |card| a = true if card.rank == 'A' }
    a
  end

  def show_cards
    @hand.map(&:output_card).join(' ')
  end

  def hide_cards
    @hand.map { |_card| '*' }.join(' ')
  end

  def cards_max?
    hand.size == 3
  end
end

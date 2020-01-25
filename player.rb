# frozen_string_literal: true

class Player
  attr_accessor :hand, :score
  attr_reader :name, :bank

  def initialize(name = 'Dealer')
    @name = name
    @bank = Bank.new(100)
    @hand = []
    @score = 0 #score of the game
  end

  def handle(deck, number = 1)
    number.times { @hand << deck.cards.shift }
  end

  def check_points
    s = @hand.sum { |card| card.value }
    s -= 10 if s > 21 && include_a?
    s
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

  protected

  def include_a?
    @hand.any? { |card| card.rank == 'A' }
  end
end

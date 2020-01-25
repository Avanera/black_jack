# frozen_string_literal: true

class Player
  attr_accessor :hand, :score
  attr_reader :name, :bank

  def initialize(name = 'Dealer')
    @name = name
    @bank = Bank.new(Bank::BALANCE)
    @hand = []
    @score = 0 # score of the game
  end

  def handle(deck, number = 1)
    number.times { @hand << deck.give_card }
  end

  def points
    s = @hand.sum(&:value)
    s -= 10 if s > 21 && include_ace?
    s
  end

  def show_cards
    @hand.map(&:output_card).join(' ')
  end

  def hide_cards
    @hand.map { '*' }.join(' ')
  end

  def cards_max?
    hand.size == 3
  end

  def exceed_limit?
    points > 21
  end

  protected

  def include_ace?
    @hand.any?(&:ace?) # @hand.any? { |card| card.ace? }
  end
end

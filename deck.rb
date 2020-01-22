# frozen_string_literal: true

class Deck
  attr_accessor :cards

  def initialize
    ranks = [*(2..10), 'J', 'Q', 'K', 'A']
    suits = %w[♠ ♥ ♣ ♦]
    @cards = []

    ranks.each do |rank|
      suits.each do |suit|
        @cards << Card.new(rank, suit)
      end
    end

    @cards.shuffle!
  end

  # def deal(number)
  #   number.times {@cards.shift.output_card}
  # end
end

# @deck = Deck.new
# @deck.deal(2)

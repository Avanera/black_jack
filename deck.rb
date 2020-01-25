# frozen_string_literal: true

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    Card::RANKS.each do |rank|
      Card::SUITS.each do |suit|
        @cards << Card.new(rank, suit)
      end
    end

    @cards.shuffle!
  end
end

# frozen_string_literal: true

class Card
  attr_accessor :rank, :suit, :value

  RANKS = [*(2..10), 'J', 'Q', 'K', 'A'].freeze
  SUITS = %w[♠ ♥ ♣ ♦].freeze

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value_of_rank(rank)
    if %w[J Q K].include?(rank)
      10
    elsif rank == 'A'
      11 # && (@points + @value > 21)  #TODO value = 1 if player.points + value >21
    else
      rank
    end
  end

  def output_card
    "#{@rank}#{@suit} "
  end
end

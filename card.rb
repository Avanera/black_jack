# frozen_string_literal: true

class Card
  attr_reader :rank, :suit, :value

  RANKS = [*(2..10), 'J', 'Q', 'K', 'A'].freeze
  SUITS = %w[♠ ♥ ♣ ♦].freeze

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @value = value_of_rank(rank)
  end

  def output_card
    "#{@rank}#{@suit} "
  end

  protected

  def value_of_rank(rank)
    if %w[J Q K].include?(rank)
      10
    elsif rank == 'A'
      11
    else
      rank
    end
  end
end

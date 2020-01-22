# frozen_string_literal: true

class Card
  attr_accessor :rank, :suit, :value
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @value = @rank if @rank.class == Integer
    @value = 10 if @rank == 'J' || @rank == 'Q' || @rank == 'K'
    if @rank == 'A'
      @value = 11 || 1
    end 
    # && (@points + @value > 21)  #TODO value = 1 if player.points + value >21
  end

  def output_card
    print "#{@rank}#{@suit} "
  end
end

# frozen_string_literal: true

class Dealer < Player
  def move(deck)
    if cards_max? || points >= 17
      nil
    else
      handle(deck)
      @hand.last
    end
  end
end

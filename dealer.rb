# frozen_string_literal: true

class Dealer < Player
  def move
    check_cards_amount
    add if points < 17
    skip if points >= 17
  end
end

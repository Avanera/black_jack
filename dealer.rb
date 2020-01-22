# frozen_string_literal: true

class Dealer < Player
  def move
    check_cards_amount
    add if @points < 17
    change_player if @points >= 17
  end
end

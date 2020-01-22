# frozen_string_literal: true

class User < Player
  def move
    # check_cards_amount

    # if skip was - no skip
    # if 3 cards - no add
    puts 'Enter 1 to skip a move, 2 to add a card, 3 to open cards.'
    choice = gets.chomp
    case choice
    when '1'
      change_player
    when '2'
      add
    when '3'
      open_cards
    end
  end
end

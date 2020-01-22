# frozen_string_literal: true

class Player
  attr_accessor :bank, :hand, :points
  attr_reader :name

  def initialize(name = 'Dealer')
    @name = name
    @bank = 100
    @hand = []
    @points = 0
  end

  def check_bank
    puts "#{@name} has #{@bank} dollars."
  end

  def handle(number)
    number.times { @hand << Game.deck.cards.shift }
    @hand.each { |card| @points += card.value } # wrong REDO
    print "#{@name} has in hand "
    show_user_cards
    puts " . #{@points} points." if self.class == User
  end

  def show_user_cards
    @hand.each do |card|
      if self.class == Dealer
        print '* '
      else
        card.output_card
      end
    end
  end

  def change_player
    # TODO ask for new game if
    Game.dealer.move if self.class == User
    Game.user.move if self.class == Dealer
  end

  def add
    handle(1)
    change_player
  end

  def open_cards
    print 'You have '
    @hand.each(&:output_card)
    print ', Dealer has '
    Game.dealer.hand.each(&:output_card)
    # TODO show points and winner, then bank - to winner, then ask fow new game
  end

  def check_cards_amount
    open_cards if Game.dealer.hand.size == 3 && Game.user.hand.size == 3
  end
end

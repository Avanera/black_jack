# frozen_string_literal: true

class Bank
  attr_reader :balance
  BALANCE = 100

  def initialize(number = 0)
    @balance = number
  end

  def credit(number)
    @balance += number
  end

  def debit(number)
    @balance -= number
  end
end

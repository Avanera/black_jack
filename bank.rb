# frozen_string_literal: true

class Bank
  attr_reader :account

  def initialize(number)
    @account = number
  end

  def credit(number)
    @account += number
  end

  def debit(number)
    @account -= number
  end
end

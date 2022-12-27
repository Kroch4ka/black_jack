# frozen_string_literal: true

class BasePlayer

  attr_reader :name, :bank

  def initialize(name, started_bank)
    @bank = started_bank
    @name = name
    @cards = []
  end

  def add_card(card)
    @cards << card
  end
  
  def bet(value)
    ban -= value if enough_for_bet? value
  end
  
  def enough_for_bet?(value)
    bank - value >= 0
  end

  private

  attr_reader :cards
end

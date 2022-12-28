# frozen_string_literal: true

class BasePlayer

  STARTED_BANK = 100

  attr_reader :name, :bank, :cards

  def initialize(name, started_bank = STARTED_BANK)
    @bank = started_bank
    @name = name
    @cards = []
  end

  def add_card(card)
    @cards << card
    self
  end

  def bet(value)
    if enough_for_bet? value
      self.bank -= value
      value
    end
  end

  def enough_for_bet?(value)
    bank - value >= 0
  end

  def get_money(value)
    @bank += value
    self
  end

  def total
    cards.reduce(0) { |first, second| first + second.value }
  end

  protected

  attr_accessor :bank
end

# frozen_string_literal: true

require_relative './errors/player_error'

class Player
  DEFAULT_BANK = 100

  attr_reader :name, :bank

  def initialize(name, bank = DEFAULT_BANK)
    @name = name
    @bank = bank
  end

  def place_bet(bet)
    raise PlayerError, "Not enough money, bet = #{bet}, bank = #{bank}" unless enough_money_for_bet? bet

    self.bank -= bet
  end

  def increase_bank(bank)
    self.bank += bank
  end

  private

  attr_writer :bank

  def enough_money_for_bet?(bet)
    bank - bet >= 0
  end
end

# frozen_string_literal: true
require_relative 'player/ayer'
class Dealer < BasePlayer
  DEFAULT_NAME = 'Dealer'
  def initialize(_, started_bank)
    super DEFAULT_NAME, started_bank
  end
end

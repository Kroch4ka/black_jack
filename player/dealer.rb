# frozen_string_literal: true
require_relative 'base_player'
class Dealer < BasePlayer
  DEFAULT_NAME = 'Dealer'
  def initialize
    super DEFAULT_NAME
  end
end

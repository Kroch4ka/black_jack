# frozen_string_literal: true
require_relative 'deck'
class Game
  STARTED_BET = 10
  def initialize(player, dealer)
    @player = player
    @dealer = dealer
    @current_move_player = @player
    @deck = Deck.new
    card_distribution
  end

  private

  attr_reader :current_move_player, :player, :dealer, :deck

  def card_distribution
    player.add_card(deck.pull).add_card(deck.pull)
    dealer.add_card(deck.pull).add_card(deck.pull)
    player.bet STARTED_BET
    dealer.bet STARTED_BET
  end
end

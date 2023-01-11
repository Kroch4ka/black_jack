# frozen_string_literal: true

require_relative 'roles/player_role'
require_relative 'roles/dealer_role'
require_relative 'deck'
require_relative 'errors/game_error'

class Game
  def initialize(player_instance, dealer_instance)
    @player = PlayerRole.new player_instance
    @dealer = DealerRole.new dealer_instance
    @deck = Deck.new
    @current_move = @player
    @winner = nil
  end

  def over?
    !!winner
  end

  def move(action)

  end

  private

  attr_reader :player, :dealer, :deck, :current_move
  attr_accessor :winner

  def determine_winner

  end
end

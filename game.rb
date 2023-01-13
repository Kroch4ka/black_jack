# frozen_string_literal: true

require_relative 'roles/player_role'
require_relative 'roles/dealer_role'
require_relative 'deck'
require_relative 'errors/game_error'

class Game

  DEFAULT_BET = 10

  attr_reader :winner, :player, :dealer, :deck

  def initialize(player_instance, dealer_instance)
    @player = PlayerRole.new player_instance
    @dealer = DealerRole.new dealer_instance
    @deck = Deck.new
    @current_move_player = @player
    @bank = 0
    @winner = nil
    deal_cards
  end

  def over?
    !!winner
  end

  def move(action)
    raise GameError, 'Unpermitted action!' unless permitted_action? action

    if player.hand.size == 3 || dealer.hand.size == 3
      complete
      return
    end

    case action
    when :open_cards then complete
    when :add_card then current_move_player.add_card(deck.pull)
    end

    switch_move
  end

  def dealer_move?
    current_move_player == dealer
  end

  def player_move?
    current_move_player == player
  end

  private

  attr_reader :bank
  attr_writer :winner
  attr_accessor :current_move_player

  def complete
    determine_winner
    winner_bank_allocation
  end

  def switch_move
    self.current_move_player = current_move_player == player ? dealer : player
  end

  def permitted_action?(action)
    current_move_player.permitted_actions.include? action
  end

  def determine_winner
    self.winner = if 21 - player.points > 21 - dealer.points
                    :dealer
                  else
                    :player
                  end
    self.winner = :dealer if player.points > 21
    self.winner = :dead_heat if player.points == dealer.points
  end

  def winner_bank_allocation
    case winner
    when :dealer then dealer.player.increase_bank bank
    when :player then player.player.increase_bank bank
    when DEAD_HEAT
      dealer.player.increase_bank DEFAULT_BET
      player.player.increase_bank DEFAULT_BET
    else raise GameError, 'Undefined bank allocation action'
    end
  end

  def deal_cards
    player.add_card deck.pull
    player.add_card deck.pull
    dealer.add_card deck.pull
    dealer.add_card deck.pull

    player.player.place_bet DEFAULT_BET
    dealer.player.place_bet DEFAULT_BET
  end
end

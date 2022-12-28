# frozen_string_literal: true
require_relative 'deck'
class Game
  STARTED_BET = 10
  DRAW = :draw

  attr_reader :winner, :current_move_player
  def initialize(player, dealer)
    @player = player
    @dealer = dealer
    @current_move_player = @player
    @deck = Deck.new
    @finished = false
    @winner = nil
    @bank = 0
    deal_cards
  end

  def finished?
    @finished
  end

  def add_card
    current_move_player.add_card deck.pull
    open_cards if current_move_player.cards.size == 3
  end

  def skip_move
    self.current_move_player =
      case current_move_player
      when player then dealer
      when dealer then player
      else raise 'Undefined move!('
      end
  end

  def open_cards
    @finished = true
    determine_winner
  end

  def player_actions
    if player.cards.size <= 2
      %i[skip_move add_card open_cards]
    else
      %i[skip_move open_cards]
    end
  end

  def dealer_actions
    if dealer.total >= 17
      %i[skip_move]
    else
      %i[add_card]
    end
  end

  private

  attr_reader :player, :dealer, :deck
  attr_writer :current_move_player

  def deal_cards
    player.add_card(deck.pull).add_card(deck.pull)
    dealer.add_card(deck.pull).add_card(deck.pull)
    @bank += player.bet STARTED_BET
    @bank += dealer.bet STARTED_BET
  end

  def determine_winner
    player_points = player.total
    dealer_points = dealer.total

    if player_points > 21 || (player_points - 21 > dealer_points - 21)
      dealer.get_money @bank
      @winner = dealer
    elsif player_points == dealer_points
      dealer.get_money STARTED_BET
      player.get_money STARTED_BET
      @winner = DRAW
    else
      player.get_money @bank
      @winner = player
    end
  end
end

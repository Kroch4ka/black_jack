# frozen_string_literal: true

class DealerBot

  def initialize(game)
    @game = game
  end

  def move
    return :skip_move if game.dealer.points >= 17

    :add_card if game.dealer.points < 17
  end

  private

  attr_reader :game, :dealer
end

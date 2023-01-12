# frozen_string_literal: true

require_relative 'base_role'

class PlayerRole < BaseRole
  def permitted_actions
    if hand.size == 3
      %i[skip_move open_cards]
    elsif hand.size <= 2
      %i[skip_move add_card open_cards]
    end
  end
end

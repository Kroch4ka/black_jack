# frozen_string_literal: true

require_relative 'base_role'

class PlayerRole < BaseRole
  def permitted_actions
    %i[skip_move add_card open_cards]
  end
end

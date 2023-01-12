# frozen_string_literal: true
require_relative 'base_role'
class DealerRole < BaseRole
  def permitted_actions
    if points > 17
      %i[skip_move]
    else
      %i[skip_move add_card]
    end
  end
end

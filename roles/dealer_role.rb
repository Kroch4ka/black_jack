# frozen_string_literal: true
require_relative 'base_role'
class DealerRole < BaseRole
  def permitted_actions
    %i[skip_move add_card]
  end
end

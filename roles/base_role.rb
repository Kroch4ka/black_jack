# frozen_string_literal: true

class BaseRole

  attr_reader :player

  def initialize(player_instance)
    @player = player_instance
    @hand = []
    @points = 0
  end

  def add_card(card)
    hand << card
    calculate_points
  end

  def permitted_actions; end

  private

  attr_reader :hand
  attr_accessor :points

  def calculate_points
    hand.each do |card|
      self.points += card.rank.eql?(:ace) ? calculate_ace_value : card.value
    end
  end

  def calculate_ace_value
    points + 11 > 21 ? 1 : 11
  end
end

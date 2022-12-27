# frozen_string_literal: true
require_relative 'card'
class Deck

  def initialize
    @deck = generate_cards
  end

  def pull
    deck.shift
  end

  private

  attr_reader :deck

  def generate_cards
    result = []
    Card::SUITS.each do |suit|
      Card::RANK_MAP.each_key { |rank| result << Card.new(rank, suit) }
    end
    result.shuffle!
  end
end

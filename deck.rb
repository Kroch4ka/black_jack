# frozen_string_literal: true
require_relative 'card'
class Deck

  def initialize
    @deck = []
    generate
    deck.shuffle!
  end

  def pull
    deck.pop
  end

  private

  attr_reader :deck

  def generate
    Card::SUITS.each do |suit|
      Card::NUMBER_RANKS.each do |rank|
        deck << Card.new(rank, suit)
      end

      Card::IMAGE_RANKS.each_key do |rank|
        deck << Card.new(rank, suit)
      end
    end
  end
end
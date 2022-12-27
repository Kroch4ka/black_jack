# frozen_string_literal: true

class Deck
  Card = Struct.new(:rank, :suit) do
    def value(total_points)
      RANK_MAP[:rank].call total_points
    end
  end

  SUITS = %(:diamond heart club spade).freeze
  RANK_MAP = {
    '2' => proc { 2 },
    '3' => proc { 3 },
    '4' => proc { 4 },
    '5' => proc { 5 },
    '6' => proc { 6 },
    '7' => proc { 7 },
    '8' => proc { 8 },
    '9' => proc { 9 },
    jack: proc { 10 },
    queen: proc { 10 },
    king: proc { 10 },
    ace: proc { |points| points + 11 <= 21 ? 11 : 1 }
  }.freeze

  @cards = []

  class << self
    attr_reader :cards

    generate_cards
  end

  private_class_method def self.generate_cards
    SUITS.each do |suit|
      RANK_MAP.each_key { |rank| cards << Card.new(rank, suit) }
    end
  end

  def initialize
    @deck = self.class.cards.shuffle
  end

  def pull(total_points)
    @deck.shift.value total_points
  end
end

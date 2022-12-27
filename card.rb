# frozen_string_literal: true

class Card
  SUITS = %i[diamond heart club spade].freeze
  RANK_MAP = {
    '2' => 2,
    '3' => 3,
    '4' => 4,
    '5' => 5,
    '6' => 6,
    '7' => 7,
    '8' => 8,
    '9' => 9,
    jack: 10,
    queen: 10,
    king: 10,
    ace: 11
  }.freeze

  attr_reader :rank, :suit, :value

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @value = RANK_MAP[@rank]
  end
end

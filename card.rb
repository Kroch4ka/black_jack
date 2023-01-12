# frozen_string_literal: true

class Card
  SUITS = %i[diamond heart club spade].freeze
  IMAGE_RANKS = {
    ace: 11,
    jack: 10,
    queen: 10,
    king: 10
  }.freeze
  NUMBER_RANKS = [2, 3, 4, 5, 6, 7, 8, 9, 10].freeze

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    return rank.to_i if digit_rank?

    IMAGE_RANKS[rank]
  end

  def digit_rank?
    rank.to_s =~ /[2-9]|(10)/
  end
end

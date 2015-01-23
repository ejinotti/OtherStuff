class Card

  CARD_VALUES = {
    :two    => 2,
    :three  => 3,
    :four   => 4,
    :five   => 5,
    :six    => 6,
    :seven  => 7,
    :eight  => 8,
    :nine   => 9,
    :ten    => 10,
    :jack   => 11,
    :queen  => 12,
    :king   => 13,
    :ace    => 14
  }

   CARD_STRS = {
    :two    => "2",
    :three  => "3",
    :four   => "4",
    :five   => "5",
    :six    => "6",
    :seven  => "7",
    :eight  => "8",
    :nine   => "9",
    :ten    => "10",
    :jack   => "J",
    :queen  => "Q",
    :king   => "K",
    :ace    => "A"
  }

  SUIT_STRS = {
    :clubs    => "♣",
    :diamonds => "♦",
    :hearts   => "♥",
    :spades   => "♠"
  }

  SUIT_COLORS = {
    :clubs    => :black,
    :diamonds => :red,
    :hearts   => :red,
    :spades   => :black
  }

  attr_reader :suit

  def initialize(val, suit)
    @value = val
    @suit = suit
  end

  def value
    CARD_VALUES[@value]
  end

  def self.suits
    SUIT_STRS.keys
  end

  def self.values
    CARD_VALUES.keys
  end

  def self.numvalues
    CARD_VALUES.keys
  end

  def render
    suitstr = SUIT_STRS[@suit]
    "#{suitstr}#{CARD_STRS[@value]}#{suitstr}".colorize(SUIT_COLORS[@suit])
  end
end

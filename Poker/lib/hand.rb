class Hand

  include Comparable

  HAND_VALUES = {
    :straight_flush   => 9,
    :four_of_a_kind   => 8,
    :full_house       => 7,
    :flush            => 6,
    :straight         => 5,
    :three_of_a_kind  => 4,
    :two_pair         => 3,
    :one_pair         => 2,
    :high_card        => 1,
    :unknown          => 0
  }

  attr_reader :tiebreakers


  def initialize(cards)
    @cards = cards
    @tiebreakers = []
    @value = :unknown
    analyze_hand
  end


  def replace_cards(indices, new_cards)
    indices.each_index do |i|
      @cards[indices[i]] = new_cards[i]
    end
    analyze_hand
  end


  def render
    output = []
    @cards.each { |card| output << card.render }
    puts output.join(" ")
    puts " 1   2   3   4   5"
    nil
  end


  def value
    HAND_VALUES[@value]
  end


  def <=>(other_hand)
    if self.value < other_hand.value
      return -1
    elsif self.value > other_hand.value
      return 1

    # tiebreakers!
    else
      (@tiebreakers.length - 1).downto(0) do |i|
        if @tiebreakers[i] < other_hand.tiebreakers[i]
          return -1
        elsif @tiebreakers[i] > other_hand.tiebreakers[i]
          return 1
        end
      end
    end

    0
  end


  private #==============================================================


  def analyze_hand
    counts = Hash.new(0)

    @cards.each { |card| counts[card.value] += 1 }
    vals = get_values.sort
    flush = (get_suits.uniq.count == 1)
    straight = false

    # set straight flag
    if counts.length == 5

      # check for ace-low straight
      if vals.last == 14 && vals[-2] == 5 && (vals[-2] - vals[0]) == 3
        straight = true

      # else check all other straights
      elsif (vals.last - vals.first) == 4
        straight = true
      end
    end

    # check for straight flush
    if straight && flush
      @value = :straight_flush
      @tiebreakers = vals
      return
    end

    # check for four of a kind
    if counts.has_value?(4)
      @value = :four_of_a_kind
      @tiebreakers = [counts.key(1), counts.key(4)]
      return
    end

    # check for full house
    if counts.has_value?(3) && counts.has_value?(2)
      @value = :full_house
      @tiebreakers = [counts.key(2), counts.key(3)]
      return
    end

    # check for plain flush
    if flush
      @value = :flush
      @tiebreakers = vals
      return
    end

    # check for plain straight
    if straight
      @value = :straight
      @tiebreakers = vals
      return
    end

    # check for three of a kind
    if counts.has_value?(3)
      kickers = counts.select { |k,v| v == 1 }.keys.sort
      @value = :three_of_a_kind
      @tiebreakers = kickers + [counts.key(3)]
      return
    end

    # check for two pair
    if counts.length == 3
      pairs = counts.select { |k,v| v == 2 }.keys.sort
      @value = :two_pair
      @tiebreakers = [counts.key(1)] + pairs
      return
    end

    # check for one pair
    if counts.has_value?(2)
      kickers = counts.select { |k,v| v == 1 }.keys.sort
      @value = :one_pair
      @tiebreakers = kickers + [counts.key(2)]
      return
    end

    # otherwise it's just high card
    @value = :high_card
    @tiebreakers = vals

    nil
  end


  def get_suits
    suits = []
    @cards.each { |c| suits << c.suit }
    suits
  end



  def get_values
    vals = []
    @cards.each { |c| vals << c.value }
    vals
  end

end

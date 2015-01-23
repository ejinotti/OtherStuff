class Deck

  def initialize(cards = nil)
    @cards = []

    if cards.nil?
      Card.suits.each do |suit|
        Card.values.each do |value|
          @cards << Card.new(value, suit)
        end
      end
    else
      @cards = cards
    end

    @cards.shuffle!
  end

  def draw(num)
    raise PokerError.new("not enough cards") if count < num
    @cards.shift(num)
  end

  def count
    @cards.length
  end

end

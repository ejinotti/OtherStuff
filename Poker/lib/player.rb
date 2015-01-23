class Player

  attr_reader :money
  attr_accessor :hand

  def initialize(name, money)
    @name, @money = name, money
    @hand = nil
  end


  def get_discard
    @hand.render
    puts "Choose up to 3 cards to replace (use 1-5 with spaces)."
    puts "If you don't want to replace anything, just press enter."
    input = gets.chomp
    parse_discard(input)
  end


  def parse_discard(input)
    input = input.split(/\s+/)
    if input.size > 3
      raise PokerError.new("Max of 3 cards can be replaced!")
    end

    if input.any? { |num| num !~ /^[1-5]$/ }
      raise PokerError.new("Bad input!")
    end

    input.map(&:to_i)
  end


  def get_move
    @hand.render
    puts "Enter whether you wish to Call, Raise, or Fold [C/R/F]."
    input = gets.chomp
    parse_move(input)
  end


  def parse_move(input)
    input.downcase!

    case input
    when 'c' then return :call
    when 'r' then return :raise
    when 'f' then return :fold
    end

    raise PokerError.new("Bad input!")
  end


  def get_raise
    puts "How much do you wish to raise?"
    input = gets.chomp
    parse_raise(input)
  end


  def parse_raise(input)
    raise PokerError.new("Bad input!") if input !~ /^(\d+)$/
    amount = $1.to_i
    raise PokerError.new("Not enough money!") if amount > @money
    amount
  end


  def take_call(call_amount)
    puts "#{call_amount} taken from #{@name} to Call the current bet."
    @money -= call_amount
  end


  def take_raise(raise_amount)
    puts "#{raise_amount} taken from #{@name} to Raise."
    @money -= raise_amount
  end


  def pay_winnings(winnings)
    puts "#{winnings} paid to winner, #{@name}."
    @money += winnings
  end
end

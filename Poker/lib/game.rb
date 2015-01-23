require_relative 'card'
require_relative 'deck'
require_relative 'hand'
require_relative 'player'
require 'colorize'

class Game

  MIN_BET = 10


  def initialize(players = nil)
    @deck = nil
    @pot = 0

    if players.nil?
      @players = []
      5.times { |i| @players << Player.new("Player#{i}", 1_000) }
    else
      @players = players
    end
  end


  def play
    round = 1

    while true

      @deck = Deck.new

      @players.each { |player| player.hand = Hand.new(deck.draw(5)) }
      puts "New hands dealt, begin round #{round}!"

      do_betting_round
      do_discard_round
      do_betting_round

      determine_winner

      round += 1
    end
  end


  private #==========================================================

  def do_betting_round
    turn = 0
    curr_bet = 10
    last_responder = @players.count - 1

    loop do
      player = @players[turn]

      next if player.hand.nil?

      begin

        move = player.get_move
        case move

        when :call
          if player.money < curr_bet
            raise PokerError.new("#{player.name}, not enough money to call!")
          end
          player.take_call(curr_bet)
          @pot += curr_bet

        when :raise
          raise_amt = player.get_raise
          player.take_call(curr_bet)
          player.take_raise(raise_amt)
          @pot += curr_bet + raise_amt
          curr_bet += raise_amt
          last_responder = (turn - 1) % @players.count

        when :fold
          player.hand = nil
        end

      rescue PokerError => e
        puts e.message
        retry
      end

      break if turn == last_responder
      turn = (turn + 1) % @players.count
    end
  end

  def do_discard_round
  end

  def determine_winner
    survivors = @players.select { |player| player.hand }

    if survivors.length == 1
      puts "#{survivors[0].name} is the winner!"
      survivors[0].pay_winnings(@pot)
      @pot = 0
    else
      hands = survivors.each { |surv| hands << surv.hand }

      winners = survivors.select{ |surv| surv.hand == hands.max }

      if winners.length == 1
        puts "#{winners[0]} is the winner!"
        winners[0].pay_winnings(@pot)
        @pot = 0
      else
        puts "We have #{winners.length} winners!"
        winners.each { |win| win.pay_winnings(@pot / winners.length) }
        @pot = 0
      end
    end
  end

end

class PokerError < StandardError
end

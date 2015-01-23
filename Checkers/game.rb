require_relative 'board'
require_relative 'piece'
require_relative 'settings'
require 'colorize'
#require 'yaml'

class Game

  def initialize(player1, player2)
    @board = Board.new(BOARD_SIZE)
    @players = { red: player1, black: player2 }
    @turn = :red
  end


  def play
    system "clear" or system "cls"
    puts

    until @board.over?
      begin
        puts
        @board.display
        @players[@turn].play_turn(@board, @turn)
      rescue InvalidMoveError, CheckersInputError => e
        puts e.message
        retry
      end

      @turn = (@turn == :red) ? :black : :red
    end

    puts "Team #{@board.winner.to_s.capitalize} is victorious!"

    nil
  end
end


class HumanPlayer


  def play_turn(board, team)
    print "#{COLORS[team].to_s.capitalize} to move. Input your move: "
    input = gets.chomp

    coords = input.split(/\s+/)

    moves = translate_coords(coords)

    piece_to_move = board[moves.first]

    if piece_to_move.nil?
      raise InvalidMoveError.new("No piece there!")
    elsif piece_to_move.team != team
      raise InvalidMoveError.new("That's not your piece!")
    end

    move_seq = moves[1..-1]

    piece_to_move.perform_moves(move_seq)

    nil
  end


  private #=========================================================


  def translate_coords(coords)

    raise CheckersInputError.new("Bad input!") if coords.length < 2

    new_coords = []

    coords.each do |coord|

      if coord !~ /^[a-hA-H]{1}(\d+)$/ || $1.to_i > BOARD_SIZE
        p $1
        raise CheckersInputError.new("Bad input!")
      # elsif $1.to_i > (BOARD_SIZE - 1)
      #   raise CheckersInputError.new("Bad input!")
      end

      new_coords_one = coord[0].downcase.bytes[0] - 'a'.ord
      new_coords_two = 8 - coord[1].to_i
      new_coords << [new_coords_two, new_coords_one]
    end

    new_coords
  end
end


class ComputerPlayer
end


class InvalidMoveError < StandardError
end


class CheckersInputError < StandardError
end

if __FILE__ == $PROGRAM_NAME
  # blah blah blah
end

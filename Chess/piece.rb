class Piece
  attr_reader :color
  attr_accessor :pos, :board

  def initialize(board,color)
    @pos = nil
    @board = board
    @color = color
  end

  def inspect
    "#{pos} #{color} #{self.class}"
  end

  def moves
    "moves"
  end

  def valid_moves
    moves.reject { |pos| move_into_check?(pos) }
  end

  def move_into_check?(new_pos)
    new_board = @board.dup
    new_board.move!(pos, new_pos)
    new_board.in_check?(color)
  end

  def render
  end
end

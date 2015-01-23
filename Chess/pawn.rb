class Pawn < Piece

  attr_accessor :first_move, :en_passant

  def initialize(board,color)
    super(board,color)
    @first_move = true
  end

  def moves
    moves = []
    direction = @color == :black ? 1 : -1

    new_pos = [pos.first + direction, pos.last]
    moves << new_pos if @board[new_pos].nil? && new_pos.first.between?(0,7)

    if @board[new_pos].nil? && @first_move
      new_pos = [pos.first + 2 * direction, pos.last]
      moves << new_pos if @board[new_pos].nil?
    end

    # captures
    new_pos = [pos.first + direction, pos.last + 1]
    moves << new_pos if (!@board[new_pos].nil? &&
              @board[new_pos].color != color) ||
              @board.en_passant == new_pos

    new_pos = [pos.first + direction, pos.last - 1]
    moves << new_pos if (!@board[new_pos].nil? &&
              @board[new_pos].color != color) ||
              @board.en_passant == new_pos
    moves
  end

  def render
    color == :black ? "\u265F" : "\u2659"
  end
end

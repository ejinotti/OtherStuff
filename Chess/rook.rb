class Rook < SlidingPiece

  attr_accessor :first_move

  def initialize(board,color)
    super(board,color)
    @first_move = true
  end

  def moves
    super(DELTAS[:straightlines])
  end

  def render
    color == :black ? "\u265C" : "\u2656"
  end
end

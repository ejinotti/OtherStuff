class Queen < SlidingPiece
  def moves
    super(DELTAS[:diagonals]) + super(DELTAS[:straightlines])
  end

  def render
    color == :black ? "\u265B" : "\u2655"
  end
end

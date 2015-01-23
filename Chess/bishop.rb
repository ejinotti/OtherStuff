class Bishop < SlidingPiece

  def moves
    super(DELTAS[:diagonals])
  end

  def render
    color == :black ? "\u265D" : "\u2657"
  end
end

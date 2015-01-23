class Knight < SteppingPiece

  DELTAS = [[2,1],[2,-1],[-2,1],[-2,-1],
            [1,2],[1,-2],[-1,2],[-1,-2]]

  def moves
    super(DELTAS)
  end

  def render
    (color == :black) ? "\u265E" : "\u2658"
  end
end

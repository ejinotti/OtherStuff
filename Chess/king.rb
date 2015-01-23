class King < SteppingPiece

  DELTAS = [[0,1],[1,0],[0,-1],[-1,0],
            [1,1],[-1,-1],[1,-1],[-1,1]]

  attr_accessor :first_move

  def initialize(board,color)
    super(board,color)
    @first_move = true
  end

  def moves
    move_list = super(DELTAS)

    return move_list unless self.first_move

    return move_list if @board.in_check?(@color)

    # Kingside
    kingside_rook = @board[[pos.first, pos.last + 3]]

    if kingside_rook.first_move
      positions = [[pos.first, pos.last + 1], [pos.first, pos.last+2]]

      if positions.all? { |loc| @board[loc].nil? && !move_into_check?(loc) }
        move_list << positions.last
      end
    end

    # Queenside
    queenside_rook = @board[[pos.first, pos.last - 4]]

    if queenside_rook.first_move
      positions = [[pos.first, pos.last - 1 ],
                  [pos.first, pos.last - 2]]
      b_square = [pos.first, pos.last - 3]
      if @board[b_square].nil? &&
        positions.all? { |loc| @board[loc].nil? && !move_into_check?(loc) }
        move_list << positions.last
      end
    end
    move_list
  end

  def render
    color == :black ? "\u265A" : "\u2654"
  end
end

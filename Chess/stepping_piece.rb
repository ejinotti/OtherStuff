class SteppingPiece < Piece

  def moves(deltas)
    moves = []

    deltas.each do |delta|
      new_pos = [pos.first + delta.first, pos.last + delta.last]

      next unless new_pos.first.between?(0,7) && new_pos.last.between?(0,7)

      if @board[new_pos].nil? || @board[new_pos].color != color
        moves << new_pos
      end
    end

    moves
  end

end

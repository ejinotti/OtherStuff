class SlidingPiece < Piece

  DELTAS = {
    :diagonals      => [[1,1], [-1,-1], [1,-1], [-1,1]],
    :straightlines  => [[1,0], [-1,0], [0,1], [0,-1]]
  }

  def moves(deltas)
    moves = []
    deltas.each do |delta|
      new_pos = [@pos.first + delta.first, @pos.last + delta.last]

      while new_pos.first.between?(0,7) && new_pos.last.between?(0,7)
        if @board[new_pos].nil?
          moves << new_pos
        else
          moves << new_pos if @board[new_pos].color != @color
          break
        end

        new_pos = [new_pos.first + delta.first, new_pos.last + delta.last]
      end

    end

    moves
  end


end

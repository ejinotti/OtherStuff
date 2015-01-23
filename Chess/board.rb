class Board
  COLORS = {
    :light => :default,
    :dark => :white,
    :border => :light_white,
    :highlight => :light_red
  }

  attr_accessor :en_passant, :pawn_promotion

  def initialize(grid = nil)
    if grid.nil?
      @grid = Array.new(8) { Array.new(8) }
      setup_pieces
    else
      @grid = grid
    end
  end

  def pieces(color)
    @grid.flatten.compact.select { |piece| piece.color == color }
  end

  def in_check?(color)
    enemy_color = color == :black ? :white : :black

    our_king_pos = pieces(color).select { |piece| piece.is_a?(King) }[0].pos

    pieces(enemy_color).any? do |piece|
      next if piece.is_a?(King)
      piece.moves.include?(our_king_pos)
    end
  end

  def checkmate?(color)
    in_check?(color) && pieces(color).all? { |piece| piece.valid_moves.empty? }
  end

  def stalemate?(color)
    !in_check?(color) && pieces(color).all? do |piece|
      piece.valid_moves.empty?
    end
  end

  def inspect
    @grid
  end

  def move(start_pos,end_pos, color)
    validate_move(start_pos,end_pos, color)

    self.move!(start_pos, end_pos)
  end

  def move!(start_pos, end_pos)
    self[start_pos].first_move = false if self[start_pos].is_a?(Rook)

    check_king(start_pos, end_pos)
    check_pawn(start_pos, end_pos)

    self[end_pos] = self[start_pos]
    self[start_pos] = nil
  end

  def dup
    grid_copy = Array.new(8) {Array.new(8)}
    board_copy = Board.new(grid_copy)

    grid_copy.each_index do |row|
      grid_copy[row].each_index do |col|
        next if @grid[row][col].nil?
        piece = @grid[row][col]
        board_copy[[row,col]] = piece.class.new(board_copy, piece.color)
      end
    end

    board_copy
  end

  def [](pos)
    @grid[pos.first][pos.last]
  end

  def []=(pos,piece)
    @grid[pos.first][pos.last] = piece
    piece.pos = pos unless piece.nil?
  end

  def display(move = [])
    bg1 = COLORS[:dark]
    bg2 = COLORS[:light]
    border = COLORS[:border]

    top_bot_border = "    A  B  C  D  E  F  G  H    "
                     .colorize(:background => border)
    puts top_bot_border

    color = bg1

    @grid.each_with_index do |row, idx|
      print " #{8 - idx} ".colorize(:background => border)

      row.each_with_index do |space, space_idx|
        back = move.include?([idx, space_idx]) ? COLORS[:highlight] : color

        if space.nil?
          print "   ".colorize(:background => back)
        else
          print " #{space.render} ".colorize(:background => back)
        end
        color = color == bg1 ? bg2 : bg1
      end
      color = color == bg1 ? bg2 : bg1
      print " #{8 - idx} ".colorize(:background => border)
      puts
    end
    puts top_bot_border
    nil
  end

  def promote_pawn(piece, color)
    raise MyChessError.new("Bad piece!") unless PROMOTIONS.has_key?(piece)
    self[@pawn_promotion] = PROMOTIONS[piece].new(self, color)
    @pawn_promotion = nil
  end

  private

  def validate_move(start_pos, end_pos, color)
    raise MyChessError.new("No piece @ start position!") if self[start_pos].nil?
    raise MyChessError.new("Piece can't move there!") unless self[start_pos]
          .moves.include?(end_pos)
    raise MyChessError.new("Causes check!") unless self[start_pos]
          .valid_moves.include?(end_pos)
    raise MyChessError.new("Wrong turn!") unless self[start_pos].color == color
  end

  def setup_pieces
    setup_nonpawn(0, :black)
    setup_nonpawn(7, :white)

    (0..7).each do |i|
      self[[1, i]] = Pawn.new(self, :black)
      self[[6, i]] = Pawn.new(self, :white)
    end
  end

  def setup_nonpawn(row, color)
    nonpawn_row = [Rook, Knight, Bishop,
      Queen, King, Bishop, Knight, Rook]
    nonpawn_row.each_with_index do |piece_class, i|
      self[[row, i]] = piece_class.new(self, color)
    end
  end

  def check_king(start_pos, end_pos)
    if self[start_pos].is_a?(King)
      self[start_pos].first_move = false

      if (end_pos.last - start_pos.last) == 2
        rook_pos = [start_pos.first, end_pos.last + 1]
        rook_end_pos = [start_pos.first, rook_pos.last - 2]
        move!(rook_pos, rook_end_pos)
      elsif (end_pos.last - start_pos.last) == -2
        rook_pos = [start_pos.first, end_pos.last - 2]
        rook_end_pos = [start_pos.first, rook_pos.last + 3]
        move!(rook_pos, rook_end_pos)
      end
    end
  end

  def check_pawn(start_pos, end_pos)
    if self[start_pos].is_a?(Pawn)
      self[start_pos].first_move = false

      if (start_pos.first - end_pos.first).abs == 2
        direction = (end_pos.first - start_pos.first) / 2
        @en_passant = [start_pos.first + direction, end_pos.last]
        @en_passant_pawn = end_pos
      elsif end_pos == @en_passant
        self[@en_passant_pawn] = nil
        @en_passant = nil
      else
        @en_passant = nil
        @pawn_promotion = end_pos if end_pos.first == 0 || end_pos.first == 7
      end
      
    else
      @en_passant = nil
    end
  end

end

class Board

  attr_reader :size, :winner


  def initialize(size, fill=true)
    @grid = Array.new(size * size)
    @size = size
    @winner = nil
    fill_board if fill
  end


  def display

    tb_border = "    A  B  C  D  E  F  G  H    "
                .colorize(:background => COLORS[:border])
    print tb_border
    bg = COLORS[:bg1]

    @grid.each_index do |i|

      if (i % @size) == 0
        bg = (bg == COLORS[:bg2]) ? COLORS[:bg1] : COLORS[:bg2]
        puts
        print " #{8 - (i / @size)} ".colorize(:background => COLORS[:border])
      end

      if @grid[i].nil?
        print "   ".colorize(:background => bg)
      else
        print " #{@grid[i].render} ".colorize(:background => bg)
      end

      if ((i+1) % @size) == 0
        print " #{8 - (i / @size)} ".colorize(:background => COLORS[:border])
      end

      bg = (bg == COLORS[:bg2]) ? COLORS[:bg1] : COLORS[:bg2]
    end

    puts
    puts tb_border
    nil
  end


  def inspect
  end


  def [](pos)
    index = pos.first * @size + pos.last
    @grid[index]
  end


  def []=(pos, piece)
    index = pos.first * @size + pos.last
    piece.pos = pos if piece
    @grid[index] = piece
  end


  def dup
    new_board = Board.new(@size, false)

    pieces.each do |piece|
      Piece.new(piece.team, new_board, piece.pos)
    end

    new_board
  end


  def over?

    if pieces.none? { |piece| piece.team == :red }
      @winner = :black
      return true
    end

    if pieces.none? { |piece| piece.team == :black }
      @winner = :red
      return true
    end

    false
  end


  private #======================================================


  def pieces
    @grid.compact
  end


  def fill_board
    pieces_per_row = @size / 2

    pieces_per_row.times do |i|
      col = i * 2
      odd_col = col + 1

      Piece.new(:black, self, [0,odd_col])
      Piece.new(:black, self, [1,col])
      Piece.new(:black, self, [2,odd_col])

      Piece.new(:red, self, [5,col])
      Piece.new(:red, self, [6,odd_col])
      Piece.new(:red, self, [7,col])
    end

    nil
  end

end

class Piece

  attr_accessor :pos
  attr_reader :team


  def initialize(team, board, pos)
    @team = team
    @board = board
    @pos = pos
    @type = :man
    @board[pos] = self
  end


  def inspect
    render
    @team
    COLORS[@team]
    @pos
    @type
  end


  def render
    color = COLORS[@team]
    @type == :man ? MAN_CHR.colorize(color) : KING_CHR.colorize(color)
  end


  def perform_moves(move_sequence)

    raise InvalidMoveError unless valid_move_seq?(move_sequence)
    perform_moves!(move_sequence)
    check_promotion
    nil
  end


  def perform_moves!(move_sequence)

    if move_sequence.length == 1
      if perform_slide(move_sequence.first)
        return nil
      else
        raise InvalidMoveError unless perform_jump(move_sequence.first)
      end

    else
      move_sequence.each do |move|
        raise InvalidMoveError unless perform_jump(move)
      end
    end

    nil
  end


  private #===========================================================


  def perform_slide(destination)
    difference = [destination.first - @pos.first,
                  destination.last - @pos.last]

    return false unless move_diffs.include?(difference)

    return false unless @board[destination].nil?

    @board[@pos] = nil
    @board[destination] = self
    true
  end


  def perform_jump(destination)

    viable_diffs = move_diffs.map do |posi|
      [posi.first * 2, posi.last * 2]
    end

    difference = [destination.first - @pos.first,
                  destination.last - @pos.last]

    return false unless viable_diffs.include?(difference)
    return false unless @board[destination].nil?

    next_spot = [@pos.first + difference.first / 2,
                 @pos.last + difference.last / 2]

    return false if @board[next_spot].nil?
    return false if @board[next_spot].team == @team

    @board[@pos] = nil
    @board[next_spot] = nil
    @board[destination] = self
    true
  end


  def valid_move_seq?(move_sequence)

    board_copy = @board.dup

    begin
      board_copy[@pos].perform_moves!(move_sequence)
    rescue InvalidMoveError
      false
    end

    true
  end


  def move_diffs
    return [[-1,1],[-1,-1],[1,1],[1,-1]] if @type == :king
    return [[-1,1],[-1,-1]] if @team == :red
    [[1,1],[1,-1]]
  end


  def check_promotion
    dest_row = @pos.first

    if @team == :red && dest_row == 0
      @type = :king
    elsif @team == :black && dest_row == (@board.size - 1)
      @type = :king
    end

    nil
  end

end

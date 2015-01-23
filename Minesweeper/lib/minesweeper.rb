require 'yaml'

class Board
  # DEFAULT_BOARD_SIZE = 9
  # DEFAULT_BOMBS = 10
  LEADERBOARD_FNAME = "msw_leaders"
  LEADERBOARD_SPOTS = 5

  attr_accessor :size

  def initialize(size=9, bombs=10)
    @time_played = 0
    @start_time = nil
    @size = size
    @board = Array.new(size)
    @bombs = bombs
    @board.each_index do |row|
      @board[row] = []

      size.times do |col|
        @board[row] << Tile.new([row,col], self)
      end
    end

    place_bombs(bombs)
  end

  def inspect
  end

  def display(show_bombs = false)
    @board.each do |row|
      row.each do |tile|
        if tile.flagged?
          print "F "
        elsif tile.revealed?
          bombs = tile.neighbor_bomb_count
          if bombs > 0
            print "#{bombs} "
          else
            print "_ "
          end
        elsif show_bombs && tile.bombed?
          print "B "
        else
          print "* "
        end
      end
      puts
    end

    nil
  end

  def play
    @start_time = Time.now
    until over?

      self.display
      puts

      action, position = self.prompt

      if action =~ /[fF]/
        self[position].place_flag
      else
        if self[position].bombed?
          self.display(true)
          puts "YOU LOSE DOORFUURSSS!"
          print_leaderboard
          return
        else
          self[position].reveal
        end
      end
    end

    self.display
    @time_played = Time.now - @start_time + @time_played
    puts "YOU WIN (DOOFUS)! Your time was #{@time_played.round(2)}"

    check_leaderboard
    print_leaderboard
  end

  def print_leaderboard
    File.readlines(LEADERBOARD_FNAME).each { |line| puts line }
  end

  def check_leaderboard(time)
    leaderboard = File.readlines(LEADERBOARD_FNAME)

    leaderboard << time.to_s

    new_leaders = leaderboard.map(&:to_f).sort.map(&:to_s).take(LEADERBOARD_SPOTS - 1)

    File.open(LEADERBOARD_FNAME, 'w') do |f|
      new_leaders.each{ |line| f.puts line }
    end
  end

  def save(filename)
    now = Time.now
    @time_played = now - @start_time
    @start_time = now
    File.open(filename,"w") { |f| f.puts (self.to_yaml) }
    puts "Saved to file \"#{filename}\"."
  end

  def self.load(filename)
    YAML::load(File.read(filename))
  end

  def prompt
    input = ""
    until input.length >= 3
      puts "Type F to place flag or R to reveal tile, ex: 'F 0 2' to flag the [0,2] tile "
      puts "You can save the game with 'S (filename)'"
      input = gets.chomp.split(/\s+/)

      save(input[1]) if (input[0] =~ /^[sS]$/ && input.length == 2)
    end
    return [input[0],[input[1].to_i,input[2].to_i]]
  end

  def over?
    (@size * @size) - @bombs == revealed_count
  end

  def revealed_count
    @board.flatten.select(&:revealed?).count
  end

  def [](pos)
    @board[pos[0]][pos[1]]
  end

  def place_bombs(num_bombs)
    rands = self.rand_pos(num_bombs)
    rands.each do |pos|
      row = pos[0]
      col = pos[1]
      @board[row][col].place_bomb
    end
  end


  def rand_pos(num)
    result = []
    until result.length == num do
      randy = [(0...@size).to_a.sample, (0...@size).to_a.sample]
      result <<  randy if !result.include?(randy)
    end
    result
  end
end

class Tile
  NEIGHBOR_DELTA = [
    [-1,-1],  #NW
    [-1,0],   #N
    [-1,1],   #NE
    [0,1],    #E
    [1,1],    #SE
    [1,0],    #S
    [1,-1],   #SW
    [0,-1]    #W
  ]

  # attr_reader :position, :rep, :has_bomb, :has_flag

  def initialize(pos, board)
    @position = pos
    @is_revealed = false
    @has_bomb = false
    @has_flag = false
    @board = board
  end

  def inspect
  end

  def bombed?
    @has_bomb
  end

  def revealed?
    @is_revealed
  end

  def flagged?
    @has_flag
  end

  def place_bomb
    @has_bomb = true
  end

  def place_flag
    raise "Already flagged doofus" if self.flagged?
    @has_flag = true
  end

  def reveal
    return if revealed?
    @is_revealed = true
    if neighbor_bomb_count == 0
      neighbors.each { |tile| tile.reveal }
    end
  end

  def is_valid?(pos)
    (pos[0].between?(0, @board.size - 1) &&
     pos[1].between?(0, @board.size - 1))
  end

  def neighbors

    # NEIGHBOR_DELTA.map
    # end
    neighbors = []
    NEIGHBOR_DELTA.each do |delta|
      dupped = @position.dup
      dupped[0] += delta[0]
      dupped[1] += delta[1]
      neighbors << @board[dupped] if is_valid?(dupped)
    end
    neighbors
  end

  def neighbor_bomb_count
    self.neighbors.select(&:bombed?).count
  end
end

if $PROGRAM_NAME == __FILE__
  #board = nil

  if ARGV.empty?
    puts "Enter file name to load or nothing for new game."
    input = gets.chomp

    board = input == "" ? Board.new : Board.load(input)

  else
    board = Board.load(ARGV[1])
  end

  board.play
end

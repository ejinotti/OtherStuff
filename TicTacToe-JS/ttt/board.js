var Board = function () {
  this.grid = [ [null,null,null], [null,null,null], [null,null,null] ];
  this.winner = null;
};

Board.prototype.dup = function() {
  var dup_board = new Board;

  for (var i = 0; i < 3; i++) {
    for (var j = 0; j < 3; j++) {
      dup_board.grid[i][j] = this.grid[i][j];
    }
  }

  return dup_board;
};

Board.prototype.isEmpty = function (x, y) {
  return (!this.grid[x][y]);
};

Board.prototype.placeMark = function (x , y , mark) {
  this.grid[x][y] = mark;
};

Board.prototype.isFull = function () {
  for (var i = 0; i < 3; i++) {
    for (var j = 0; j < 3; j++) {
      if (this.isEmpty(i,j)) {
        return false;
      }
    }
  }

  return true;
};

Board.prototype.isOver = function () {
  return (this.isFull() || this.isWon('x') || this.isWon('o'));
};

Board.prototype.isWon = function(mark) {
  var winStr = this.getRows() + this.getCols() + this.getDiags();

  if (winStr.indexOf(mark+mark+mark) === -1) {
    return false;
  }

  this.winner = mark;

  return true;
};

Board.prototype.getRows = function() {
  var rows = "";

  for (var i = 0; i < 3; i++) {
    rows += this.grid[i][0] + this.grid[i][1] + this.grid[i][2] + " ";
  }

  return rows;
};

Board.prototype.getCols = function() {
  var cols = "";

  for (var i = 0; i < 3; i++) {
    cols += this.grid[0][i] + this.grid[1][i] + this.grid[2][i] + " ";
  }

  return cols;
};

Board.prototype.getDiags = function() {
  var diags = "";

  diags += this.grid[0][0] + this.grid[1][1] + this.grid[2][2] + " ";
  diags += this.grid[0][2] + this.grid[1][1] + this.grid[2][0] + " ";

  return diags;
};

Board.prototype.print = function() {

  console.log("");
  console.log("    0   1   2  ");
  console.log("  +---+---+---+");

  for (var i = 0; i < 3; i++) {

    var line = i + " |";

    for (var j = 0; j < 3; j++) {
      if (this.isEmpty(i, j)) {
        line += "   |";
      } else if (this.grid[i][j] === 'x') {
        line += " X |";
      } else {
        line += " O |";
      }
    }

    console.log(line);
    console.log("  +---+---+---+");
  }
};

module.exports = Board;

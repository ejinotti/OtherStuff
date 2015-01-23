var Piece = require("./piece");

/**
 * Returns a 2D array (8 by 8) with two black pieces at [3, 4] and [4, 3]
 * and two white pieces at [3, 3] and [4, 4]
 */
function _makeGrid () {
  grid = [];
  for (var i = 0; i < 8; i++) {
    grid.push([]);
  }

  for (var i = 0; i < 8; i++) {
    for (var j = 0; j < 8; j ++) {
      grid[i][j] = null;
    }
  }

  grid[3][4] = new Piece("black");
  grid[4][3] = new Piece("black");
  grid[3][3] = new Piece("white");
  grid[4][4] = new Piece("white");

  return grid;
}

/**
 * Constructs a Board with a starting grid set up.
 */
function Board () {
  this.grid = _makeGrid();
}

Board.DIRS = [
  [ 0,  1], [ 1,  1], [ 1,  0],
  [ 1, -1], [ 0, -1], [-1, -1],
  [-1,  0], [-1,  1]
];

/**
 * Returns the piece at a given [x, y] position,
 * throwing an Error if the position is invalid.
 */
Board.prototype.getPiece = function (pos) {
  if (!this.isValidPos(pos)) {
    throw "position off the board!";
  }

  return this.grid[pos[0]][pos[1]];
};

/**
 * Checks if there are any valid moves for the given color.
 */
Board.prototype.hasMove = function (color) {
  return this.validMoves(color).length != 0;
};

/**
 * Checks if every position on the Board is occupied.
 */
Board.prototype.isFull = function () {
  for (var i=0; i < 8; i++) {
    for (var j=0; j < 8; j++) {
      if (this.grid[i][j] === null) {
        return false;
      }
    }
  }

  return true;
};

/**
 * Checks if the piece at a given position
 * matches a given color.
 */
Board.prototype.isMine = function (pos, color) {
  return this.getPiece(pos).color === color;
};

/**
 * Checks if a given position has a piece on it.
 */
Board.prototype.isOccupied = function (pos) {
  return (this.grid[pos[0]][pos[1]] === null) ? false : true;
};

/**
 * Checks if both the white player and
 * the black player are out of moves.
 */
Board.prototype.isOver = function () {
  return (this.validMoves("black").length === 0 &&
          this.validMoves("white").length === 0);
};

/**
 * Checks if a given position is on the Board.
 */
Board.prototype.isValidPos = function (pos) {
  if (pos[0] < 0 || pos[0] > 7 || pos[1] < 0 || pos[1] > 7) {
    return false;
  }

  return true;
};

/**
 * Recursively follows a direction away from a starting position, adding each
 * piece of the opposite color until hitting another piece of the current color.
 * It then returns an array of all pieces between the starting position and
 * ending position.
 *
 * Returns null if it reaches the end of the board before finding another piece
 * of the same color.
 *
 * Returns null if it hits an empty position.
 *
 * Returns null if no pieces of the opposite color are found.
 */
 function _positionsToFlip (board, pos, color, dir, piecesToFlip) {
   if (!this.isValidPos(pos)) { return null; }

     var piece = getPiece(pos);

     if (piece === null || piece.color === color) { return null; }

       pieceToFlip.concat(pos).concat(_positionsToFlip(board, pos.addDelta(dir), color, dir, ))
     }

function _positionsToFlip (board, pos, color, dir) {
  if (!this.isValidPos(pos)) { return ["invalid"]; }

  var piece = getPiece(pos);
  if (piece === null) { return ["invalid"]; }
  if (piece.color === color) { return []; }

  var flips = [pos].concat(_positionsToFlip(board, pos.addDelta(dir), color, dir));
  if (flips[flips.length-1] === "invalid") {
    return [];
  }

  return flips.slice(1);
}

/**
 * Adds a new piece of the given color to the given position, flipping the
 * color of any pieces that are eligible for flipping.
 *
 * Throws an error if the position represents an invalid move.
 */
Board.prototype.placePiece = function (pos, color) {
};

/**
 * Prints a string representation of the Board to the console.
 */
Board.prototype.print = function () {
  for (var i = 0; i < 8; i++) {
    var row = "|";
    for (var j = 0; j < 8; j++) {
      if (this.getPiece([i,j]) === "black") {
        row += " ● |";
      } else if (this.getPiece([i,j]) === "white") {
        row += " ○ |";
      } else {
        row += "   |";
      }
    }
    console.log(row);
  }
};

/**
 * Checks that a position is not already occupied and that the color
 * taking the position will result in some pieces of the opposite
 * color being flipped.
 */
Board.prototype.validMove = function (pos, color) {
  if (this.isOccupied(pos)) { return false };

  for (var i=0; i < self.DIRS.length; i++) {
    if (_positionsToFlip(this, pos, color, self.DIRS[i]).length === 0) {
      return true;
    }
  }

  return false;
};

Array.prototype.addDelta = function (delta) {
  return [this[0] + delta[0], this[1] + delta[1]];
}

/**
 * Produces an array of all valid positions on
 * the Board for a given color.
 */
Board.prototype.validMoves = function (color) {
  var vmoves = [];
  for (var i = 0; i < 8; i++) {
    for (var j = 0; j < 8; j++) {
      if this.validMove([i,j], color) {
        vmoves.push([i,j]);
      }
    }
  }

  return vmoves;
};

module.exports = Board;

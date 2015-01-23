var Board = require('./board');

var Game = function(reader,xPlayer,oPlayer) {
  this.board = new Board();
  this.reader = reader;
  this.turn = 0;
  this.players = [xPlayer, oPlayer]
};

Game.prototype.run = function (completionCallback) {
  var game = this;

  var move = this.players[this.turn]
    .getInput(this.reader, (game.turn) ? 'o' : 'x',
              this.board, function (move) {

    var row = move[0];
    var col = move[1];

    if (game.board.isEmpty(row, col)) {
      game.board.placeMark(row, col, (game.turn) ? 'o' : 'x');
      game.turn = (game.turn + 1) % 2;
    } else {
      console.log("That spot is already taken!");
    }

    if (game.board.isOver()) {
      game.board.print();
      completionCallback(game.board.winner);
    } else {
      game.run(completionCallback);
    }

  });

  return;
};

module.exports = Game;

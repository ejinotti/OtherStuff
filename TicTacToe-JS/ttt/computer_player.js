var ComputerPlayer = function () {

};

ComputerPlayer.prototype.getInput = function (reader, turn, board, callback) {
  var moves = [];

  for (var i = 0; i < 3; i++) {
    for (var j = 0; j < 3; j++) {
      if (board.isEmpty(i,j)) {
        var dup_board = board.dup();
        dup_board.placeMark(i,j,turn);
        if (dup_board.isWon(turn)) {
          callback([i,j]);
          return;
        }
        else {
          moves.push([i,j]);
        }
      }
    }
  }


  callback(moves[Math.floor((Math.random() * moves.length))]);


};

module.exports = ComputerPlayer;

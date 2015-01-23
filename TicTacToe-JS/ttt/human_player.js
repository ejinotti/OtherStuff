var HumanPlayer = function () {

};

HumanPlayer.prototype.getInput = function (reader, turn, board, callback) {
  var player = this;

  var move = [];

  board.print();

  console.log(turn + ", it is your turn." );

  reader.question("Please input your move row: ", function (rowInput) {
    reader.question("Please input your move column: ", function (colInput) {

      if (!rowInput.match(/^[0-2]$/) || !colInput.match(/^[0-2]$/)) {
        console.log("Bad Input");
        player.getInput(reader, turn, callback);
        return;
      }

      var rowInt = parseInt(rowInput);
      var colInt = parseInt(colInput);
      callback([rowInt,colInt]);
    });

  });

  return;
};

module.exports = HumanPlayer;

var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});


var ticTacToe = require('./ttt');

var human = new ticTacToe.HumanPlayer();
var computer = new ticTacToe.ComputerPlayer();
var game = new ticTacToe.Game(reader, computer, human);

game.run( function (winner) {
  if (winner) {
    console.log(winner + " has won the game!");
  }
  else {
    console.log("The game is a draw!");
  }

  reader.close();
  return;
})

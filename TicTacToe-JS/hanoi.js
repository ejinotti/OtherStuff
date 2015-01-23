var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var HanoiGame = function () {
  this.stacks = [[3,2,1],[],[]];

};

HanoiGame.prototype.isWon = function () {
  this.print();
  return (this.stacks[0].length === 0 &&
    (this.stacks[1].length === 0 || this.stacks[2].length === 0));
}

HanoiGame.prototype.isValidMove = function (startTowerIdx, endTowerIdx) {

  if (this.stacks[startTowerIdx].length === 0) {
    return false;
  }
  var startTower = this.stacks[startTowerIdx]
  var endTower =  this.stacks[endTowerIdx]
  return (startTower[startTower.length - 1] < endTower[endTower.length - 1] ||
    endTower.length === 0);
}

HanoiGame.prototype.move = function(startTowerIdx, endTowerIdx) {
  if (this.isValidMove(startTowerIdx, endTowerIdx)) {
    var block = this.stacks[startTowerIdx].pop();
    this.stacks[endTowerIdx].push(block);
    return true;
  }

  return false;
};

HanoiGame.prototype.print = function() {
  console.log(JSON.stringify(this.stacks));
  return;
};

HanoiGame.prototype.promptMove = function(callback) {
  this.print();
  that = this;

  reader.question("From which tower:", function(startTowerStr) {
    reader.question("To which tower:", function(endTowerStr) {

      if (!startTowerStr.match(/^[0-2]$/) || !endTowerStr.match(/^[0-2]$/)) {
        console.log("Bad input!");
        that.promptMove(callback);
        return;
      }

      var startTowerIdx = parseInt(startTowerStr);
      var endTowerIdx = parseInt(endTowerStr);

      callback(startTowerIdx, endTowerIdx);
    });
  });

  return;
};

HanoiGame.prototype.run = function(completionCallback) {
  this.promptMove(function(startTowerIdx, endTowerIdx) {
    if (this.move(startTowerIdx, endTowerIdx)) {
      if (this.isWon()) {
        completionCallback();
      } else {
        this.run(completionCallback);
      }
    } else {
      console.log("Invalid move!");
      this.run(completionCallback);
    }
  }.bind(this));
};

game = new HanoiGame();

game.run(function () {
  console.log("Congratulations, you isWon!");
  reader.close();
});

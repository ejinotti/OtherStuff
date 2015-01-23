var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

//var completionCallback

var addNumbers = function(sum, numsLeft, completionCallback) {

  if (numsLeft > 0) {
    reader.question("Give a number:", function (numString) {
      var num = parseInt(numString);

      sum += num;
      console.log("Current Sum: " + sum);

      addNumbers(sum, numsLeft - 1, completionCallback);
    });
  } else {
    completionCallback(sum);
  }
};

addNumbers(0, 2, function (sum) {
  console.log("Total Sum: " + sum);
});

reader.close();

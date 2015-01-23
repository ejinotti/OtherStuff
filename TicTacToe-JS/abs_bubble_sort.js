var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});


var askIfLessThan = function(el1,el2, callback) {
  console.log( "el1 is : " + el1);
  console.log( "el2 is : " + el2);
  reader.question("Is el1 <= el2?", function(response) {
    if (response === 'yes') {
      callback(true);
    }
    else if (response === 'no') {
      callback(false);
    }
    else {
      console.log("Invalid Response!")
      askIfLessThan(el1,el2,callback);
    }

    return;
  });

  return;
};

var innerBubbleSortLoop = function (arr, i , madeAnySwaps, outerBubbleSortLoop) {
  if (i < arr.length - 1) {
    askIfLessThan(arr[i],arr[i+1], function(isLessThan) {
      if (!isLessThan) {
        var tmp = arr[i+1];
        arr[i+1] = arr[i];
        arr[i] = tmp;
        innerBubbleSortLoop(arr, i+1, true, outerBubbleSortLoop);
      } else {
        innerBubbleSortLoop(arr, i+1, madeAnySwaps, outerBubbleSortLoop);
      }

      return;
    });
  } else {
    outerBubbleSortLoop(madeAnySwaps);
  }

  return;
};

var absurdBubbleSort = function (arr, sortCompletionCallback) {

  var outerBubbleSortLoop = function (madeAnySwaps) {
    if (madeAnySwaps) {
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    } else {
      sortCompletionCallback(arr);
    }
  };

  outerBubbleSortLoop(true);

  return;
};

absurdBubbleSort([3, 2, 1], function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
});

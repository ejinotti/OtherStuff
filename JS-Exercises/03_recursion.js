var range = function(start, end) {
  if (start === end) {
    return [start];
  }

  return [start].concat(range(start+1, end));
};

var isum = function(numbers) {
  var sum = 0;

  for (var i=0; i < numbers.length; i++) {
    sum += numbers[i];
  }

  return sum;
};

var rsum = function(numbers) {
  if (numbers.length === 1) {
    return numbers[0];
  }

  return numbers[0] + rsum(numbers.slice(1));
};


var exp1 = function(n, pow) {
  if (pow === 0) {
    return 1;
  }

  return n * exp1(n, pow-1);
};

var exp2 = function(n, pow) {
  if (pow === 0) {
    return 1;
  } else if (pow % 2 === 0) {
    var next = exp2(n, pow/2)
    return next * next;
  } else {
    var next = exp2(n, (pow-1)/2)
    return n * (next * next);
  }

};

var rfib = function(n) {
  if (n === 1) {
    return [0];
  } else if (n === 2) {
    return [0,1];
  } else {
    var p_fib = rfib(n-1);
    var length = p_fib.length;
    return p_fib.concat(p_fib[length - 1] + p_fib[length - 2]);
  }
};

var ifib = function(n) {
  if (n === 1) {
    return [0];
  } else if (n === 2) {
    return [0,1];
  }

  var fibs = [0,1];

  for (var i=2; i < n; i++) {
    fibs.push(fibs[i-2] + fibs[i-1]);
  }

  return fibs;
};

var bsearch = function(arr, target) {
  var mid_idx = parseInt(arr.length / 2);
  var mid_val = arr[mid_idx];

  if (mid_val === target) {
    return mid_idx;
  } else if (mid_val > target) {
    return bsearch(arr.slice(0, mid_idx), target);
  } else {
    return bsearch(arr.slice(mid_idx), target) + mid_idx;
  }
};

var make_change = function(amount, coins) {
  var best_change = [];
  var current_change = [];

  if (amount === 0) {
    return current_change;
  }

  for (var i = 0; i < coins.length; i++) {

    if (coins[i] <= amount) {

      current_change = [coins[i]].concat(make_change(amount-coins[i], coins))

      if (best_change.length === 0 || current_change.length < best_change.length) {
        best_change = current_change;
      }
    }
  }

  return best_change;
};

var merge_sort = function(arr) {
  if (arr.length <= 1) {
    return arr;
  }

  var mid_idx = parseInt(arr.length / 2);

  var left = arr.slice(0, mid_idx);
  var right = arr.slice(mid_idx);

  return merge(merge_sort(left), merge_sort(right));
};

var merge = function(left, right) {
  var merged = [];

  while (left.length > 0 && right.length > 0) {
    if (left[0] < right[0]) {
      merged.push(left.shift());
    } else {
      merged.push(right.shift());
    }
  }

  return merged.concat(left).concat(right);
};

Array.prototype.myEach = function (block) {
  for (var i=0; i<this.length; i++) {
    block(this[i]);
  }
};

Array.prototype.myMap = function (block) {
  var result = [];

  this.myEach(function(num) {
    result.push(block(num));
  });

  return result;
};

var subsets = function(arr) {
  if (arr.length === 0) {
    return [[]];
  }

  prev_subsets = subsets(arr.slice(1));
  new_subsets = prev_subsets.myMap(
    function (el) {
      return [arr[0]].concat(el);
    }
  );

  return prev_subsets.concat(new_subsets);
};

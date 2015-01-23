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

Array.prototype.myInject = function(init, block) {
  var result = init;

  this.myEach(function(num) {
    result = block(result, num);
  });

  return result;
};

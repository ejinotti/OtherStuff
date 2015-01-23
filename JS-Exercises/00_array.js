Array.prototype.uniq = function() {
  var uniq_array = [];

  for (var i=0; i<this.length; i++) {
    curr_ele = this[i]
    if (this.lastIndexOf(curr_ele) === i) {
      uniq_array.push(curr_ele);
    }
  }

  return uniq_array;
};

Array.prototype.twoSum = function() {
  var indices = [];

  for (var i=0; i < this.length-1; i++) {
    for (var j=i+1; j < this.length; j++) {
      if ((this[i] + this[j]) === 0) {
        indices.push([i,j]);
      }
    }
  }

  return indices;
};

Array.prototype.transpose = function() {
  var new_matrix = [];
  for (var i = 0; i < this.length; i++) {
    new_matrix.push([]);
  }

  for (var i=0; i < this.length; i++) {
    for (var j=0; j < this.length; j++) {
      new_matrix[j][i] = this[i][j];
    }
  }

  return new_matrix;
};

Array.prototype.bubbleSort = function() {
  for(var i=0; i<this.length-1; i++) {
    for(var j=(i+1); j<this.length; j++) {
      if (this[i] > this[j]) {
        var temp = this[i];
        this[i] = this[j];
        this[j] = temp;
      }
    }
  }
};

String.prototype.substrings = function() {
  subs = [];
  for (var i=0; i<this.length; i++) {
    for(var j=i+1; j<=this.length; j++) {
      var sub = this.substring(i, j);
      if (subs.indexOf(sub) === -1) {
        subs.push(sub);
      }
    }
  }

  return subs;
};

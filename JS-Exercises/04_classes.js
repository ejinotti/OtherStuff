var Cat = function(name, owner) {
  this.name = name;
  this.owner = owner;
};

Cat.prototype.cuteStatement = function() {
  return this.owner + " loves " + this.name;
};

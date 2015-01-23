Pokedex.RootView.prototype.reassignToy = function (event) {
  var $currentTarget = $(event.currentTarget);

  var oldPoke = this.pokes.get($currentTarget.data("pokemon-id"));
  var toy = oldPoke.toys().get($currentTarget.data("toy-id"));

  toy.set("pokemon_id", $currentTarget.val());

  toy.save({}, {
    success: function (model) {
      oldPoke.toys().remove(model);
      this.renderToysList.bind(this)(oldPoke.toys());
      this.$toyDetail.empty();
    }.bind(this)
  });
};

Pokedex.RootView.prototype.renderToysList = function(toys){
  this.$pokeDetail.find(".toys").empty();
  toys.each(function(el){
    this.addToyToList.bind(this)(el);
  }.bind(this));

};

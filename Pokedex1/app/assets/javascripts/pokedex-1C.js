Pokedex.RootView.prototype.createPokemon = function (attrs, callback) {
  var newPoke = new Pokedex.Models.Pokemon(attrs);
//TODO this can all be accomplished thru Backbone Collection #create
  newPoke.save({}, {
    success: function(model) {
      this.pokes.add(model);
      this.addPokemonToList(model);
      callback(model);
    }.bind(this)
  });
};

Pokedex.RootView.prototype.submitPokemonForm = function (event) {
  event.preventDefault();
  var data = $(event.currentTarget).serializeJSON().pokemon;
  this.createPokemon(data, this.renderPokemonDetail.bind(this));
};

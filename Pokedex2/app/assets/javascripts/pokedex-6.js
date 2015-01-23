Pokedex.Router = Backbone.Router.extend({
  routes: {
    "": "pokemonIndex",
    "pokemon/:id": "pokemonDetail",
    "pokemon/:pokemonId/toys/:toyId": "toyDetail"
  },

  pokemonDetail: function (id, callback) {
    if (this._pokemonIndex) {
      var pokemon = this._pokemonIndex.collection.get(id);

      this._pokemonDetail = new Pokedex.Views.PokemonDetail({model: pokemon});
      $("#pokedex .pokemon-detail").html(this._pokemonDetail.$el);
      this._pokemonDetail.refreshPokemon({}, callback);

    } else {
      this.pokemonIndex(this.pokemonDetail.bind(this, id, callback));
    }
  },

  pokemonIndex: function (callback) {
    this._pokemonIndex = new Pokedex.Views.PokemonIndex();
    this._pokemonIndex.refreshPokemon({}, callback);
    $("#pokedex .pokemon-list").html(this._pokemonIndex.$el);
    this.pokemonForm();
  },

  toyDetail: function (pokemonId, toyId) {
    if (this._pokemonDetail) {
      var toy = this._pokemonDetail.model.toys().get(toyId);

      var toyDetail = new Pokedex.Views.ToyDetail({
        model: toy,
        collection: this._pokemonIndex.collection
      });

      $("#pokedex .toy-detail").html(toyDetail.render().$el);

    } else {
      this.pokemonDetail(pokemonId, this.toyDetail.bind(this, pokemonId, toyId));
    }
  },

  pokemonForm: function () {
    var model = new Pokedex.Models.Pokemon();
    var pokemonForm = new Pokedex.Views.PokemonForm({
      model: model,
      collection: this._pokemonIndex.collection
    });
    $('#pokedex .pokemon-form').html(pokemonForm.$el);
    pokemonForm.render();
  }
});


$(function () {
  new Pokedex.Router();
  Backbone.history.start();
});

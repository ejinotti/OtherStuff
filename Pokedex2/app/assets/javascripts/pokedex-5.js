Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    'click li.poke-list-item': 'selectPokemonFromList'
  },

  initialize: function () {
    this.collection = new Pokedex.Collections.Pokemon();
    this.listenTo(this.collection, 'add-refresh', this.render);
  },

  addPokemonToList: function (pokemon) {
    var content = JST["pokemonListItem"]({pokemon: pokemon});
    this.$el.append(content);
    return this;
  },

  refreshPokemon: function (options, callback) {

    this.collection.fetch({
      success: function () {
        this.render();
        callback && callback();
      }.bind(this)
    });
  },

  render: function () {
    console.log('render');
    this.$el.empty();
    this.collection.each(function (pokemon) {
      this.addPokemonToList(pokemon);
    }.bind(this));
    return this;
  },

  selectPokemonFromList: function (event) {
    var $target = $(event.target);

    var pokeId = $target.data('id');

    Backbone.history.navigate("/pokemon/"+pokeId, {trigger: true});
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    'click .toys li': 'selectToyFromList'
  },

  initialize: function () {
    this.listenTo(this.model.toys(), 'change-owner', this.render);
  },

  refreshPokemon: function (options, callback) {
    this.model.fetch({
      success: function () {
        this.render();
        callback && callback();
      }.bind(this)
    });
  },

  render: function () {
    var content = JST["pokemonDetail"]({pokemon: this.model});
    this.$el.html(content);
    this.model.toys().each(function (toy) {
      var content2 = JST["toyListItem"]({toy: toy});
      this.$(".toys").append(content2);
    });
    return this;
  },

  selectToyFromList: function (event) {
    var $target = $(event.target);

    var toyId = $target.data('id');
    var pokeId = $target.data('pokemon-id');

    Backbone.history.navigate("/pokemon/"+pokeId+"/toys/"+toyId, {trigger: true});
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  events: {
    'change .detail select': 'reassignToy'
  },

  render: function () {
    var content = JST["toyDetail"]({toy: this.model, pokes: this.collection});
    this.$el.html(content);
    return this;
  },

  reassignToy: function (event) {
    var $currentTarget = $(event.currentTarget);

    var pokemon = this.collection.get($currentTarget.data("pokemon-id"));
    var toy = pokemon.toys().get($currentTarget.data("toy-id"));

    toy.set("pokemon_id", $currentTarget.val());
    toy.save({}, {
      success: (function () {
        pokemon.toys().remove(toy);
        pokemon.toys().trigger('change-owner');
        this.$el.empty();
      }).bind(this)
    });
  }
});


// $(function () {
//   var pokemonIndex = new Pokedex.Views.PokemonIndex();
//   pokemonIndex.refreshPokemon();
//   $("#pokedex .pokemon-list").html(pokemonIndex.$el);
// });

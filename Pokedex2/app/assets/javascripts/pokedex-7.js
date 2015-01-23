Pokedex.Views = (Pokedex.Views || {});

Pokedex.Views.PokemonForm = Backbone.View.extend({
  events: {
    "submit .new-pokemon": "savePokemon"
  },

  render: function () {
    var content = JST["pokemonForm"]();
    this.$el.html(content);
  },

  savePokemon: function (event) {
    event.preventDefault();
    var $target = $(event.currentTarget);

    this.model.save($target.serializeJSON().pokemon, {
      success: function () {
        this.collection.add(this.model);
        this.collection.trigger('add-refresh')
        Backbone.history.navigate('pokemon/'+this.model.id, {trigger: true});
      }.bind(this)
    })
  }
});

Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  var $li = $("<li>");
  var itemText = "name: " + pokemon.escape("name");
  itemText += " poke_type: " + pokemon.escape("poke_type");
  $li.data("id", pokemon.id);
  $li.html(itemText);
  $li.addClass("poke-list-item");
  this.$pokeList.append($li);
};

Pokedex.RootView.prototype.refreshPokemon = function (callback) {
  var that = this;
  this.pokes.fetch({
    success: function (pokes){
      pokes.each (function (el){
        that.addPokemonToList(el);
      })
    }
  });
};

Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  var that = this;

  this.$pokeDetail.empty();
  this.$toyDetail.empty();

  var $div = $("<div>").addClass("detail");
  var $image = $("<img>").attr("src", pokemon.escape("image_url"));
  $div.append($image);

  var $ul = $("<ul>");
  for (var attr in pokemon.attributes) {
    if (attr !== "image_url") {
      var $li = $("<li>");
      $li.html(attr + ": " + pokemon.escape(attr));
      $ul.append($li);
    }
  }
  $div.append($ul);

  this.$toyList = $("<ul>").addClass("toys");
  $div.append(this.$toyList);

  pokemon.fetch({
    success: function(updated){
      that.renderToysList.bind(that)(updated.toys());
    }
  });

  this.$toyList.on('click', 'li', this.selectToyFromList.bind(this));

  this.$pokeDetail.append($div);
};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  var id = $(event.currentTarget).data("id");
  this.renderPokemonDetail(this.pokes.get(id));
};

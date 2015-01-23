Pokedex.RootView.prototype.addToyToList = function (toy) {
  var $li = $("<li>");
  var listText = "name: " + toy.escape("name");
  listText += " happiness: " + toy.escape("happiness");
  listText += " price: " + toy.escape("price");
  $li.html(listText).data("toy-id", toy.id).data("pokemon-id", toy.get("pokemon_id"));
  this.$toyList.append($li);
};

Pokedex.RootView.prototype.renderToyDetail = function (toy) {
  this.$toyDetail.empty();
  var $div = $("<div>").addClass("detail");

  var $image = $("<img>").attr("src", toy.escape("image_url"));
  $div.append($image);

  var $ul = $("<ul>");

  for (var attr in toy.attributes) {
    if (attr !== "image_url") {
      var $li = $("<li>");
      $li.html(attr + ": " + toy.escape(attr));
      $ul.append($li);
    }
  }

  var pokeID = toy.get("pokemon_id")
  var $select = $("<select>").data("pokemon-id", pokeID);
  $select.data("toy-id", toy.id);

  this.pokes.each(function (poke) {
    var $option = $("<option>");
    $option.val(poke.id);
    $option.html(poke.escape("name"));
    if (pokeID === poke.id){
      $option.attr("selected", "selected")
    }
    $select.append($option);
  });

  $select.on('change', this.reassignToy.bind(this));

  $div.append($ul);
  $div.append($select);

  this.$toyDetail.append($div);
};

Pokedex.RootView.prototype.selectToyFromList = function (event) {
  var $toy = $(event.currentTarget);
  var toy = this.pokes.get($toy.data("pokemon-id")).toys().get($toy.data("toy-id"))
  this.renderToyDetail(toy);
};

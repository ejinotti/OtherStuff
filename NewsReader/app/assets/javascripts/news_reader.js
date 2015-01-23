window.NewsReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    NewsReader.feeds = new NewsReader.Collections.Feeds();

    new NewsReader.Routers.Feeds({
      "$indexEl": $("#feed-index"),
      "$detailEl": $("#feed-detail")
    });
    Backbone.history.start();
  }
};

$(document).ready(function(){
  NewsReader.initialize();
});

NewsReader.Routers.Feeds = Backbone.Router.extend({
  initialize: function (options) {
    this.$indexEl = options.$indexEl;
    this.$detailEl = options.$detailEl;
  },

  routes: {
    '': 'index',
    'feeds/:id': 'feedShow'
  },

  index: function () {
    console.log('index route!');

    NewsReader.feeds.fetch();

    this.indexView = new NewsReader.Views.FeedsIndex({
      collection: NewsReader.feeds
    });

    this.$indexEl.html(this.indexView.render().$el);
  },

  feedShow: function (id) {
    console.log('feedShow route!');

    this.indexView || this.index();

    var feed = NewsReader.feeds.getOrFetch(id);
    var showView = new NewsReader.Views.FeedShow({
      model: feed
    });

    this._swapView(showView, this.$detailEl);

    // feed.fetch({
    //   success: function () {
    //
    //     var showView = new NewsReader.Views.FeedShow({
    //       model: feed
    //     });
    //
    //     this.$rootEl.html(showView.render().$el);
    //   }.bind(this)
    // });
  },

  _swapView: function (view, $elem) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    $elem.html(view.render().$el);
  }

});

NewsReader.Views.FeedNew = Backbone.View.extend({
  template: JST['feeds/new'],

  events: {
    "submit": "createNewFeed"
  },

  initialize: function () {
    this.feed = new NewsReader.Models.Feed();
  },

  render: function () {
    var content = this.template({
      feed: this.feed
    });

    this.$el.html(content);
    return this;
  },

  createNewFeed: function (event) {
    event.preventDefault();

    var that = this;
    var feedAttrs = ($(event.target).serializeJSON())['feed'];

    this.feed.save(feedAttrs, {
      success: function () {
        that.collection.add(that.feed);
      }
    });
  }
});

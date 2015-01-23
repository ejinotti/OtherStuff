NewsReader.Collections.Entries = Backbone.Collection.extend({
  model: NewsReader.Models.Entry,

  comparator: function (model) {
    return model.get('published_at');
  },

  url: function () {
    return this.feed.url() + '/entries';
  },

  initialize: function (models, options) {
    this.feed = options.feed;
  }
});

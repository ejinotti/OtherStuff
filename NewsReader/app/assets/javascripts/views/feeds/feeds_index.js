NewsReader.Views.FeedsIndex = Backbone.View.extend({
  template: JST['feeds/index'],

  events: {
    'click button': 'newFeedForm'
  },

  initialize: function () {
    this.listenTo(this.collection, 'sync', this.render);
    this.listenTo(this.collection, 'add', this.clearNewForm);
  },

  render: function () {
    var content = this.template({
      feeds: this.collection
    });

    this.$el.html(content);
    return this;
  },

  newFeedForm: function () {
    this.$formArea = this.$('#create-feed');
    this.$formArea.empty();

    this.newFormView = new NewsReader.Views.FeedNew({
      collection: this.collection
    });
    this.$formArea.html(this.newFormView.render().$el);
  },

  clearNewForm: function () {
    console.log('clearNewForm');
    this.newFormView && this.newFormView.remove();
    this.render();
  }
});

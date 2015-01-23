JournalApp.Views.PostsIndex = Backbone.View.extend({
  template: JST['PostsIndex'],

  tagName: 'ul',

  events: {
    "click button.btn-delete": "deletePost",
    "click a.show-post": "show"
  },

  initialize: function () {
    this.collection = new JournalApp.Collections.Posts();
    this.listenTo(this.collection,
      "remove add change:title reset", //phase V???
      this.render);
    this.collection.fetch();
  },

  render: function () {
    this.$el.html(this.template({posts: this.collection}));
    return this;
  },

  deletePost: function (event) {
    var postId = $(event.currentTarget).data('id');
    var post = this.collection.get(postId);
    var that = this;
    post.destroy({
      success: function () {
        that.collection.remove(post);
      }
    }); //should fire an implicit remove event on collection
  },

  show: function (event) {
    event.preventDefault();

    var postId = $(event.currentTarget).data('id');
    Backbone.history.navigate('posts/' + postId, {trigger: true})
  }
})

JournalApp.Router = Backbone.Router.extend({
  routes: {
    "": "postsIndex",
    "posts/new": "postNew",
    "posts/:id": "postShow",
    "posts/:id/edit": "postEdit"
  },

  initialize: function ($el) {
    this.$elem = $el;
    this._postsIndex = new JournalApp.Views.PostsIndex();
    $('#sidebar').html(this._postsIndex.$el);
    this.currentView = null;
  },

  // postsIndex: function () {
  //   this._swapView(this._postsIndex);
  // },

  postShow: function (id) {
    var post = this._postsIndex.collection.getOrFetch(id);
    this._postShow = new JournalApp.Views.PostShow({
      model: post
    });
    this._swapView(this._postShow);
  },

  postEdit: function (id) {
    var post = this._postsIndex.collection.getOrFetch(id);
    this._postEdit = new JournalApp.Views.PostForm({
      model: post,
      collection: this._postsIndex.collection
    });
    this._swapView(this._postEdit);
  },

  postNew: function () {
    var newPost = new JournalApp.Models.Post();
    this._postEdit = new JournalApp.Views.PostForm({
      model: newPost,
      collection: this._postsIndex.collection
    });
    this._swapView(this._postEdit);
  },

  _swapView: function (newView) {
    if (this.currentView) {
      this.currentView.remove();
    }

    this.$elem.html(newView.render().$el);

    this.currentView = newView;
  }
});

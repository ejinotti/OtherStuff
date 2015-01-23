JournalApp.Collections.Posts = Backbone.Collection.extend({

  url: "/posts",
  model: JournalApp.Models.Post,

  getOrFetch: function (id) {
    var posts = this;
    var post;

    if (!(post = this.get(id))) { //Gets from collection
      post = new JournalApp.Models.Post({id: id});
      post.fetch({
        success: function () {
          posts.add(post); //if post is not in collection, fetches the individual model to add to collection
        }
      });
    }

    return post;
  }
})

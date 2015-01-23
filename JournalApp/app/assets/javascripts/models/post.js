JournalApp.Models.Post = Backbone.Model.extend({
  urlRoot: '/posts',

  validate: function (attrs) {
    console.log('validating..');
    if (!attrs || !attrs.title || attrs.title === "") {
      return "cannot have empty title";
    }
    if (!attrs.body || attrs.body === "") {
      return "cannot have empty body";
    }
  }
});

JournalApp.Views.PostForm = Backbone.View.extend({
  template: JST['PostForm'],

  events: {
    "submit": "submitPostForm"
  },

  initialize: function () {
    this.listenTo(this.model, "invalid", this.showErrors);
  },

  submitPostForm: function (event) {
    event.preventDefault();

    var postAttrs = ($(event.target).serializeJSON())['post'];
    var that = this;
    this.model.save(postAttrs, {
      success: function () {
        console.log('success!');
        that.collection.add(that.model, { merge: true });
        Backbone.history.navigate('', { trigger: true });
      },
      error: function () {
        console.log('error detected!')
        that.render();
      }
    });
  },

  render: function () {
    this.$el.html(this.template({post: this.model}))
    return this;
  },

  showErrors: function () {
    this.$('.errors').html(this.model.validationError);
  }

});

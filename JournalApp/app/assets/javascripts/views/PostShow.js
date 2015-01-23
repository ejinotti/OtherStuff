JournalApp.Views.PostShow = Backbone.View.extend({
  events: {
    "click .back": "back",
    "dblclick .body": "editBody",
    "dblclick .title": "editTitle",
    "blur .body": "saveBody",
    "blur .title": "saveTitle"
  },

  template: JST['PostShow'],


  initialize: function () {
    this.listenTo(this.model, "invalid", this.showErrors);
  },

  render: function () {
    this.$el.html(this.template({ post: this.model }));
    return this;
  },

  back: function (event) {
    Backbone.history.navigate("",{trigger: true})
  },

  editTitle: function () {
    var $title = this.$('.title');

    $title.html(
      $('<input class="title-input" type="text">')
      .val(this.model.escape('title')));
  },

  editBody: function () {
    var $body = this.$('.body');

    $body.html(
      $('<textarea class="body-input">')
      .val(this.model.escape('body')));
  },

  // editField: function (fieldName) {
  //   var $fieldContainer = this.$('.' + fieldName);
  //
  //   var tagName = (fieldName === 'title' ? 'input' : 'tetarea');
  //   var inlineHtml = '<' + tagName + ' class="' + tagName + '-input">';
  //   var $field = $(inlineHtml).val(this.model.escape(fieldName));
  //
  //   $fieldCOntainer.html($field)
  // },

  saveTitle: function () {
    var $titleInput = this.$('.title-input');
    var newTitle = $titleInput.val();
    this.model.save({title: newTitle},{
      success: function () {
        this.$('.title').html(this.model.escape('title'));
        this.$('.errors').empty();
      }.bind(this)
    });
  },

  saveBody: function () {
    var $bodyInput = this.$('.body-input');
    var newBody = $bodyInput.val();
    this.model.save({body: newBody},{
      success: function () {
        this.$('.body').html(this.model.escape('body'));
        this.$('.errors').empty();
      }.bind(this)
    });
  },

  showErrors: function () {
    this.$('.errors').html(this.model.validationError);
  }

})

window.JournalApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    new JournalApp.Router($('#content'));
    Backbone.history.start();
  }
};

$(document).ready(function(){
  JournalApp.initialize();
});

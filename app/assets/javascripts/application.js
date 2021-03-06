// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require_tree .

$(function(){ $(document).foundation(); });

$(function() {
  var buttonPressed = '';

  $("input.button.info.tiny.radius").click(function() {
    buttonPressed = $(this)[0].id;
  });

  $("form.upvote").submit(function(event) {
    event.preventDefault();

    var attributes = getAttributes(buttonPressed);
    var voteCreator = newVoteCreator(attributes);
    voteCreator.upVote();
  });

  $("form.downvote").submit(function(event) {
    event.preventDefault();

    var attributes = getAttributes(buttonPressed);
    var voteCreator = newVoteCreator(attributes);
    voteCreator.downVote();
  });

  $("form.deletevote").submit(function(event) {
    event.preventDefault();

    var attributes = getAttributes(buttonPressed);
    var voteCreator = newVoteCreator(attributes);
    voteCreator.deleteVote();
  });
});

var getAttributes = function(button_pressed) {
  var idClicked = button_pressed.substring(button_pressed.lastIndexOf('-')+1);
  var attributes = { id: idClicked };
  return attributes;
};

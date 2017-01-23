var newVoteCreator = function(reviewAttributes, divId) {
  return {
    id: reviewAttributes,
    upVote: function() {
      var voteCreatorObject = this;
      var request = $.ajax({
        method: "POST",
        url: "/api/v1/reviews/" + reviewAttributes.id + "/upvote",
        data: { reviewAttributes }
      });

      request.done(function() {
        voteCreatorObject.setFlash("notice", "Thank you for your vote!");
        voteCreatorObject.updateScore(1, reviewAttributes.id);
      });

      request.error(function() {
        voteCreatorObject.setFlash("error", "There was a problem with your vote.");
      });
    },
    downVote: function() {
      var voteCreatorObject = this;
      var request = $.ajax({
        method: "POST",
        url: "/api/v1/reviews/" + reviewAttributes.id + "/downvote",
        data: { reviewAttributes }
      });

      request.done(function() {
        voteCreatorObject.setFlash("notice", "Thank you for your vote!");
        voteCreatorObject.updateScore(-1, reviewAttributes.id);
      });

      request.error(function() {
        voteCreatorObject.setFlash("error", "There was a problem with your vote.");
      });
    },
    deleteVote: function() {
      var voteCreatorObject = this;
      var request = $.ajax({
        method: "POST",
        url: "/api/v1/reviews/" + reviewAttributes.id + "/deletevote",
        data: { reviewAttributes }
      });

      request.done(function(data) {
        voteCreatorObject.setFlash("notice", "Your vote was deleted.");

        if (data.vote_type == 'up') {
          voteCreatorObject.updateScore(-1, reviewAttributes.id);
        } else {
          voteCreatorObject.updateScore(1, reviewAttributes.id);
        }
      });

      request.error(function() {
        voteCreatorObject.setFlash("error", "There was a problem with your vote.");
      });
    },
    setFlash: function(type, message) {
      $("div.flash").remove();
      var flash = $("<div>", { "class": "flash flash-" + type }).text(message);
      $("body").prepend(flash);
    },
    updateScore: function(score, divId) {
      var currentScore = $("div#vote-" + divId + " span").text();
      currentScore = parseInt(currentScore) + score;

      $("div#vote-" + divId + " span").text(currentScore);
    }
  };
};

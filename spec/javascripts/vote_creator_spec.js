describe("Vote", function () {
  beforeEach(function() {
    jasmine.Ajax.install();
  });

  afterEach(function() {
    jasmine.Ajax.uninstall();
  });

  var attributes = { id: "2" };
  var voteCreator = newVoteCreator(attributes);

  describe("new", function() {
    it("creates a new voteCreator object", function() {
      expect(voteCreator).toBeDefined();
    });
  });

  describe("upVote", function() {
    it("issues a POST request to /api/v1/reviews/2/upvote", function() {
      voteCreator.upVote();

      var request = jasmine.Ajax.requests.mostRecent();

      expect(request.method).toBe("POST");
      expect(request.url).toBe("/api/v1/reviews/2/upvote");
    });

    it("notifies the user after upvoting the review", function() {
      spyOn(voteCreator, "setFlash");
      voteCreator.upVote();
      var request = jasmine.Ajax.requests.mostRecent();
      request.respondWith({ status: 201 });

      expect(voteCreator.setFlash).toHaveBeenCalled();
    });
  });

  describe("downVote", function() {
    it("issues a POST request to /api/v1/reviews/2/downvote", function() {
      voteCreator.downVote();

      var request = jasmine.Ajax.requests.mostRecent();

      expect(request.method).toBe("POST");
      expect(request.url).toBe("/api/v1/reviews/2/downvote");
    });

    it("notifies the user after downvoting the review", function() {
      spyOn(voteCreator, "setFlash");
      voteCreator.downVote();
      var request = jasmine.Ajax.requests.mostRecent();
      request.respondWith({ status: 201 });

      expect(voteCreator.setFlash).toHaveBeenCalled();
    });
  });

  describe("deleteVote", function() {
    it("issues a POST request to /api/v1/reviews/2/deletevote", function() {
      voteCreator.deleteVote();

      var request = jasmine.Ajax.requests.mostRecent();

      expect(request.method).toBe("POST");
      expect(request.url).toBe("/api/v1/reviews/2/deletevote");
    });

    it("notifies the user after deleting the vote", function() {
      spyOn(voteCreator, "setFlash");
      voteCreator.downVote();
      voteCreator.deleteVote();
      var request = jasmine.Ajax.requests.mostRecent();
      request.respondWith({
        'status': 201,
        'content/type': 'application/json'
      });

      expect(voteCreator.setFlash).toHaveBeenCalled();
    });
  });

  describe("setFlash", function() {
    it("adds a new div to the body of the DOM", function() {
      voteCreator.setFlash("notice", "Hey there!");
      var flash = $("div.flash-notice");
      expect(flash.text()).toBe("Hey there!");
    });
  });
});

# README

A review site for hotels. Users can add, edit, delete hotel, and can rate hotels and leave an optional review. Admin users who can delete inappropriate material or users. It's written in Ruby on Rails.

This application provides the following functionality:
* The ability to sign in and sign up, using Devise for authentication.
* The ability of an authenticated user to upvote or downvote a review, similar to Reddit. A user can only upvote or downvote a review once and can change his or her vote from up to down utilizing AJAX.
* A search bar that allows a user to sift through items displayed on the index.
* The ability to store photographs and/or profile pictures stored in the cloud, using Amazon Web Services and CarrierWave, so they are more reliably available.



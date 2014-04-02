# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

fetch_new_video = (url) ->
  $.ajax (
    url: url
    dataType: "html"
    success: (data) ->
      console.log("hello" + data)
      $(".container").html(data)

    error: (data) ->
      console.log(data)
  )

$ ->
  mixpanel.track "load_page"

  $("#record-link").click (e) ->
    mixpanel.track "fetch_song", { "source" : "record-click" }
    e.preventDefault()
    $(this).find("img").addClass("spin")
    fetch_new_video($(this).attr("href"))

  $(document).on "click", "#new-artist-button", (e) ->
    mixpanel.track "fetch_song", { "source" : "new-artist-button" }
    e.preventDefault()
    fetch_new_video($(this).attr("href"))

  $(document).on "click", "#same-artist-button", (e) ->
    mixpanel.track "fetch_song", { "source" : "same-artist-button" }
    e.preventDefault()
    fetch_new_video($(this).attr("href"))

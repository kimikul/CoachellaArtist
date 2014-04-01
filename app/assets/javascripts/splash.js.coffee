# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#record-link").click (e) ->
    e.preventDefault()
    $(this).find("img").addClass("spin")

    $.ajax (
      url: "/artist/index"
      dataType: "html"
      success: (data) ->
        console.log("hello" + data)
        $(".container").html(data)

      error: (data) ->
        console.log(data)
    )

  $(document).on "click", "#new-artist-button", (e) ->
    console.log("alksdjf;alksjdla")
    e.preventDefault()
    $.ajax
      url: "/artist/index"
      dataType: "html"
      success: (data) ->
        console.log("hello" + data)
        $(".container").html(data)

      error: (data) ->
        console.log(data)


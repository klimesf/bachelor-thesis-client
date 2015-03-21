$ = require 'jquery'

$(".ajax-call").click ->
  alert "AJAX call triggered"
  $.ajax
    url: "api-call.html"
    dataType: "html"
    error: (jqHXR, textStatus, errorThrown) ->
      $("body").append "AJAX Error: #{textStatus}"
    success: (data, textStatus, jqXHR) ->
      $("body").append "Successful AJAX call #{data}"
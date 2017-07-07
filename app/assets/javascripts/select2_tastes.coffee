select2_taste = ->
  $(".select2-taste").select2
    allowClear: true
    theme: 'bootstrap'
    language: 'ru'
    width: null

$(document).on("turbolinks:before-cache", ->
  $('.select2-taste').select2('destroy'))

$(document).on('turbolinks:load', select2_taste)

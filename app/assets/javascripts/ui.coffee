$(document).on('turbolinks:load', -> $('.ui.dropdown').dropdown())
$(document).on('turbolinks:load', -> $('.ui.checkbox').checkbox())

sticky_menu = ->
  $('.main.menu').visibility
    type: 'fixed'
  $('.overlay').visibility
    type: 'fixed'
    offset: 80

$(document).on('turbolinks:load', sticky_menu)

sidebar = ->
  $('.ui.sidebar').sidebar('attach events', '#open-sidebar, #close-sidebar')

$(document).on('turbolinks:load', sidebar)

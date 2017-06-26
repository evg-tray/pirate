stick_navbar = ->
  s = $('#main-navbar')
  $('.nav-wrapper').css('height', s.css('height'))
  pos = s.position()
  $(window).scroll ->
    windowpos = $(window).scrollTop()
    if windowpos >= pos.top
      s.addClass 'navbar-fixed-top'
    else
      s.removeClass 'navbar-fixed-top'

$(document).on('turbolinks:load', stick_navbar)

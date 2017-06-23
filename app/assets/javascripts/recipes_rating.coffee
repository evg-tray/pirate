user_rating = ->
  $('.user-rating').raty
    path: '/assets/'
    cancel: $('.user-rating').data('cancel')
    readOnly: ->
      $(this).data('readonly')
    score: ->
      $(this).data('score')
    hints: [null, null, null, null, null]
    cancelHint : 'Удалить мой голос'
    cancelOff : 'fa fa-fw fa-times-circle',
    cancelOn  : 'fa fa-fw fa-times-circle'
    noRatedMsg: 'Для голосования необходимо войти в учетную запись'
    click: (score) ->
      $.ajax({
        type: "POST",
        url: '/vote-recipe',
        data: { score: score, recipe_id: $(this).attr('id') }
      })

$(document).on("turbolinks:before-cache", ->
  $('.user-rating').raty('destroy'))

$(document).on('turbolinks:load', user_rating)

total_rating = ->
  $('.total-rating').raty
    path: '/assets/'
    readOnly: true
    hints: [null, null, null, null, null]
    noRatedMsg: 'Нет голосов'
    score: ->
      $(this).attr('data-score')

$(document).on("turbolinks:before-cache", ->
  $('.total-rating').raty('destroy'))

$(document).on('turbolinks:load', total_rating)

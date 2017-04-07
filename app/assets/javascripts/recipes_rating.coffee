user_rating = ->
  $('.user-rating').raty
    path: '/assets/'
    cancel: $('.user-rating').data('cancel')
    readOnly: ->
      $(this).data('readonly')
    score: ->
      $(this).data('score')
    click: (score) ->
      $.ajax({
        type: "POST",
        url: '/vote_recipe',
        data: { score: score, recipe_id: $(this).attr('id') }
      })

$(document).on('turbolinks:load', user_rating)

total_rating = ->
  $('.total-rating').raty
    path: '/assets/'
    readOnly: true
    score: ->
      $(this).attr('data-score')

$(document).on('turbolinks:load', total_rating)

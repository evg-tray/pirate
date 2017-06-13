ui_user_rating = ->
  rating_object = $('.ui.rating.user')
  $('.ui.rating.user').rating
    maxRating: 5
    onRate: (value) ->
      $.ajax({
        type: "POST",
        url: '/vote-recipe',
        data: { score: value, recipe_id: $(this).attr('id') }
      })
    clearable: true
  if rating_object.data('readonly')
    rating_object.rating('disable')

$(document).on('turbolinks:load', ui_user_rating)

ui_total_rating = ->
  $('.ui.rating.total').rating(maxRating: 5).rating('disable')

$(document).on('turbolinks:load', ui_total_rating)

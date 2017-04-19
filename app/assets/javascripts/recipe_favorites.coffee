add_fav = (event) ->
  event.preventDefault()
  recipe_id = $(this).attr('id')
  if recipe_id
    $.ajax({
      type: "POST",
      url: "/add-favorite",
      data: { id: recipe_id },
      dataType: 'script'
    })

$(document).on('click', '.add-fav', add_fav)

del_fav = (event) ->
  event.preventDefault()
  recipe_id = $(this).attr('id')
  from_list = $(this).data('from-list') || false
  if recipe_id
    $.ajax({
      type: "POST",
      url: "/delete-favorite",
      data: { id: recipe_id, from_list: from_list },
      dataType: 'script'
    })

$(document).on('click', '.del-fav', del_fav)

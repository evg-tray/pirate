remove_mod = (event) ->
  event.preventDefault()
  id = $(this).attr('id').split('-').pop()
  if id
    $.ajax({
      type: "POST",
      url: "/unset-moderator",
      data: { user_id: id },
      dataType: 'script'
    })

$(document).on('click', '.remove-mod', remove_mod)

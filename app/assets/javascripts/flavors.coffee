update_availability = (event) ->
  event.preventDefault()
  record_id = $(this).parent().attr('id').split('-').pop()
  if record_id
    $.ajax({
      type: "POST",
      url: "/availability",
      data: { id: record_id, _method: 'patch' },
      dataType: 'script'
    })

$(document).on('click', '.upd-av', update_availability)

delete_from_my_flavors = (event) ->
  event.preventDefault()
  record_id = $(this).attr('id').split('-').pop()
  if record_id
    $.ajax({
      type: "POST",
      url: "/delete-from-my-flavors",
      data: { id: record_id },
      dataType: 'script'
    })

$(document).on('click', '.delete-myflavor', delete_from_my_flavors)

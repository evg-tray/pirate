add_to_my_flavors = ->
  item_id = $('.selectable-row.bg-warning').attr('id').split('-').pop()
  if item_id
    $.ajax({
      type: "POST",
      url: "/add_to_my_flavors",
      data: { flavor: { id: item_id} },
      dataType: 'script'
    })
  $('#add_to_my_flavors_modal').modal('hide')

$(document).on('click', '#add_to_my_flavors_modal #selectbutton', add_to_my_flavors)
$(document).on('dblclick', '#add_to_my_flavors_modal .selectable-row', add_to_my_flavors)

select_row = ->
  $(this).addClass('bg-warning').siblings().removeClass('bg-warning')

$(document).on('click', '#add_to_my_flavors_modal .selectable-row', select_row)

update_availability = (event) ->
  event.preventDefault()
  record_id = $(this).parent().attr('id').split('-').pop()
  if record_id
    $.ajax({
      type: "POST",
      url: "/update_availability",
      data: { id: record_id },
      dataType: 'script'
    })

$(document).on('click', '.upd-av', update_availability)

delete_from_my_flavors = (event) ->
  event.preventDefault()
  record_id = $(this).attr('id').split('-').pop()
  if record_id
    $.ajax({
      type: "POST",
      url: "/delete_from_my_flavors",
      data: { id: record_id },
      dataType: 'script'
    })
$(document).on('click', '.delete-myflavor', delete_from_my_flavors)

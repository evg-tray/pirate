del_role = (event) ->
  event.preventDefault()
  id = $(this).parent().parent().attr('id').split('-').pop()
  if id
    $.ajax({
      type: "POST",
      url: "/del-role",
      data: { user_id: id, role: $(this).data('role') },
      dataType: 'script'
    })

$(document).on('click', '.del-role', del_role)

add_role = (event) ->
  event.preventDefault()
  selected_obj = $('.select2-tag').select2('data')[0]
  id = selected_obj.id if selected_obj
  if id
    $.ajax({
      type: "POST",
      url: "/add-role",
      data: { user_id: id, role: $(this).data('role') },
      dataType: 'script'
    })

$(document).on('click', '.add-role', add_role)

enable_disable_registration = (event) ->
  event.preventDefault()
  $.ajax({
    type: "POST",
    url: "/admin/enable-disable-registration",
    data: { disable_registraion: $(this).data('disable') },
    dataType: 'script'
  })

$(document).on('click', '.ed-reg', enable_disable_registration)

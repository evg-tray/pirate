add_table_attr = ->
  $('.rwd-table tbody td').each (index, e) ->
    $(e).attr("data-th", $(e).closest('table').find('th').eq($(e).index()).text())

$(document).on('turbolinks:load', add_table_attr)

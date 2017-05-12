select2 = ->
  $(".select2-tag").select2
    ajax:
      url: '/select'
      dataType: 'json'
      delay: 250
      data: (params) ->
        {
          adapter: $(this).data('adapter')
          term: params.term
          page: params.page
        }
      processResults: (data, params) ->
        params.page = params.page or 1
        {
          results: data.items
          pagination: more: params.page * 20 < data.total_count
        }
      cache: true
    minimumInputLength: 1
    allowClear: true
    theme: 'bootstrap'
    language: 'ru'

$(document).on('turbolinks:load', select2)
$(document).on("cocoon:after-insert", select2)

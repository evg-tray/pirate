formatResult = (data) ->
  res = data.text
  if data.type == 'f'
    res = if data.wh then "<i class=\"fa fa-heartbeat\" title=\"Вреден для здоровья\"></i>&nbsp" else ''
    res += if data.wd then "<i class=\"fa fa-warning\" title=\"Вреден для устройства\"></i>&nbsp" else ''
    res += data.fn
    res += " (<abbr title=\"" + data.mn + "\">" + data.msn + "</abbr>)"
    res += " - <abbr title='Количество рецептов'>" + data.count + "</abbr>"
    res += "<div class=\"cleafix\"></div><small>" + if data.tr then data.tr else '' + "</small>"
  else if data.type == 'm'
    res += " (" + data.msn + ")"
    res += " - <abbr title='Количество ароматизаторов'>" + data.count + "</abbr>"
  res

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
    escapeMarkup: (markup) ->
      markup
    templateResult: (data) ->
      formatResult(data)
    minimumInputLength: 1
    allowClear: true
    theme: 'bootstrap'
    language: 'ru'
    width: null

$(document).on("turbolinks:before-cache", ->
  $('.select2-tag').select2('destroy'))

$(document).on('turbolinks:load', select2)
$(document).on("cocoon:after-insert", select2)

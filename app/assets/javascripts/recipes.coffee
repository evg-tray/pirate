round2 = (value) ->
  return Math.round(value * 100) / 100

change_pg = ->
  $('#recipe_vg').val(100 - parseFloat($('#recipe_pg').val()))

change_vg = ->
  $('#recipe_pg').val(100 - parseFloat($('#recipe_vg').val()))

recipe_result_header = ->
  return false unless $('body').data('make_table')
  $('#recipe_result_header').html($('#recipe_name').val())

get_row_table = (main, percent = null, ml = null, drops = null, tr_class = null) ->
  return "<tr#{if tr_class then ' class="' + tr_class + '"' else ''}>
      <td>#{main}</td>
      <td class=\"text-right\">#{if percent then round2(percent) else ''}</td>
      <td class=\"text-right\">#{if ml then round2(ml) else ''}</td>
      <td class=\"text-right\">#{if drops then round2(drops) else ''}</td></tr>"

fill_hidden_select2_values = ->
  new_name = ''
  new_man_name = ''
  new_man_short_name = ''
  selected_obj = $(this).select2('data')[0]
  if selected_obj
    new_name = selected_obj.fn
    new_man_name = selected_obj.mn
    new_man_short_name = selected_obj.msn
  $(this).parent().find('.flavor-text').val(new_name)
  $(this).parent().find('.flavor-mn').val(new_man_name)
  $(this).parent().find('.flavor-msn').val(new_man_short_name)

recipe_result_table = ->
  return false unless $('body').data('make_table')
  amount = parseFloat($('#recipe_amount').val())
  pg = parseFloat($('#recipe_pg').val())
  vg = parseFloat($('#recipe_vg').val())
  strength = parseFloat($('#recipe_strength').val())
  nicotine_base = parseFloat($('#recipe_nicotine_base').val())
  drops = parseFloat($('#drops').val())

  flavors_rows = ''
  flavors_total_percent = 0
  flavors_total_ml = 0
  flavors_total_drops = 0
  $('.flavors-input').each (index, element) =>
    percent = parseFloat($(element).find('.number').val())
    flavor = $(element).find('.flavor-text').val() +
      ' (<abbr title=' + $(element).find('.flavor-mn').val() +
      '>' + $(element).find('.flavor-msn').val() + '</abbr>)'
    if flavor != '' & percent > 0
      ml = amount / 100 * percent
      flavor_drops = Math.round(ml * drops)
      flavors_rows += get_row_table(flavor, percent, ml, flavor_drops)
      flavors_total_percent += percent
      flavors_total_ml += ml
      flavors_total_drops += flavor_drops
  if flavors_rows != ''
    flavors_rows += get_row_table('Всего ароматизаторы:',
      flavors_total_percent,
      flavors_total_ml,
      flavors_total_drops,
      'info')

  nicotine_percent = strength * 100 / nicotine_base
  nicotine_ml = amount / 100 * nicotine_percent

  pg_max_ml = amount / 100 * pg
  pg_ml = pg_max_ml - flavors_total_ml - nicotine_ml
  pg_percent = pg_ml * 100 / amount

  vg_ml = amount / 100 * vg

  base_total_ml = pg_ml + vg_ml + nicotine_ml
  base_total_percent = pg_percent + vg + nicotine_percent

  total_ml = base_total_ml + flavors_total_ml
  total_percent = base_total_percent + flavors_total_percent

  table_rows = get_row_table('PG', pg_percent, pg_ml)
  table_rows += get_row_table('VG', vg, vg_ml)

  if nicotine_percent > 0
    table_rows += get_row_table('Никотин', nicotine_percent, nicotine_ml)

  table_rows += get_row_table('Всего основа:', base_total_percent, base_total_ml, null, 'warning')
  table_rows += flavors_rows
  table_rows += get_row_table('Всего:', total_percent, total_ml, null, 'success')
  $('#recipe_result tbody').html(table_rows)

$(document).on('input', '#recipe_vg', change_vg)
$(document).on('input', '#recipe_pg', change_pg)

$(document).on('input', '#recipe_amount, ' +
    '#recipe_pg, ' +
    '#recipe_vg, ' +
    '#recipe_strength, ' +
    '#recipe_nicotine_base, ' +
    '#drops, ' +
    '.flavors-input .number',
  recipe_result_table)

$(document).on('change', '.select2-tag.with-hidden', fill_hidden_select2_values)
$(document).on('change', '.select2-tag.with-hidden', recipe_result_table)

$(document).on('input', '#recipe_name', recipe_result_header)

$(document).on('cocoon:after-remove', recipe_result_table)

$(document).on('turbolinks:load', recipe_result_table)
$(document).on('turbolinks:load', recipe_result_header)

module Select2Helpers

  def select2(value, id_select)
    find("##{id_select} + span").click
    find('.select2-search__field').set(value)
    find('li.select2-results__option', text: value, match: :prefer_exact).click
  end
end

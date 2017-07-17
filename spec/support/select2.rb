module Select2Helpers

  def select2(value, id_select, without_dropdown = false)
    find("##{id_select} + span").click
    if without_dropdown
      find('.select2-search__field').set(value)
    else
      within '.select2-search--dropdown' do
        find('.select2-search__field').set(value)
      end
    end
    find('li.select2-results__option', text: value, match: :prefer_exact).click
  end
end

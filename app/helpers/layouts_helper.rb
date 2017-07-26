module LayoutsHelper
  def copyright_year_range
    current_year = Date.current.year
    if current_year > 2017
      "2017 - #{current_year}"
    else
      2017
    end
  end
end

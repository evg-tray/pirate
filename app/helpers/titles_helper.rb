module TitlesHelper
  def title
    site_name = t('titles.site_name')
    if action_name == 'create'
      action = 'new'
    elsif action_name == 'update'
      action = 'edit'
    else
      action = action_name
    end
    left_title = t("titles.#{controller_name}.#{action}", param: content_for(:title), default: site_name)
    left_title == site_name ? site_name : "#{left_title} | #{site_name}"
  end

  def title_param(text)
    content_for :title, text
  end
end

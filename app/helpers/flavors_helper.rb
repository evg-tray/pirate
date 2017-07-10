module FlavorsHelper
  def flavor_fields_for_table(flavor_id)
    if flavor_id && flavor_id != 0
      fields = Flavor.joins(:manufacturer).where(id: flavor_id).
          pluck(:name, 'manufacturers.name', :short_name, 'manufacturers.id')[0]
      {
          name: "#{fields[0]} (#{fields[2]})",
          fn: fields[0],
          mn: fields[1],
          msn: fields[2],
          id: flavor_id
      }
    else
      Hash.new('')
    end
  end

  def warnings(flavor)
    result = ''
    if flavor.warning_health
      result << "<i class=\"fa fa-heartbeat\" title=\"#{t('activerecord.attributes.flavor.warning_health')}\"></i>"
      result << "&nbsp"
    end
    if flavor.warning_device
      result << "<i class=\"fa fa-warning\" title=\"#{t('activerecord.attributes.flavor.warning_device')}\"></i>"
      result << "&nbsp"
    end
    result.html_safe
  end
end

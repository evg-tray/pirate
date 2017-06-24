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
end

class Manufacturer < ApplicationRecord
  has_many :flavors

  update_index 'manufacturers#manufacturer', :self
  update_index('flavors#flavor') { flavors }

  validates :name, :short_name, presence: true, uniqueness: {case_sensitive: false}
end

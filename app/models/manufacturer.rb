class Manufacturer < ApplicationRecord
  has_many :flavors

  validates :name, :short_name, presence: true, uniqueness: {case_sensitive: false}
end

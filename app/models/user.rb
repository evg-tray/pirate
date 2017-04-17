class User < ApplicationRecord
  include Storext.model
  include Validable

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :recipes, foreign_key: :author_id
  has_many :flavors, class_name: 'UserFlavor'
  has_many :votes
  has_many :comments, foreign_key: :author_id

  attr_accessor :login

  validates :username, presence: true, uniqueness: {case_sensitive: false},
            format: {with: /^[a-zA-Z0-9_\.]*$/, multiline: true}
  validates :drops, numericality: { only_integer: true, greater_than: 0 }

  scope :pirate_diy_subscribers, -> { where(subscribed: true) }

  store_attributes :settings do
    drops Integer, default: 30
    pg Integer, default: 30
    vg Integer, default: 70
    amount Integer, default: 30
    strength Float, default: 0.0
    nicotine_base Integer, default: 100
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
  end
end

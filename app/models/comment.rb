class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :recipe

  validates :text, presence: true, length: { minimum: 10 }
end

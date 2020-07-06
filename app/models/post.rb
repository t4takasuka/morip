class Post < ApplicationRecord
  belongs_to :users, optional: true
  validates :title, :text, presence: true
end

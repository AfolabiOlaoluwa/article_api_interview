class Article < ApplicationRecord
  # belongs_to :user
  belongs_to :user, optional: true

  validates_presence_of :title, :body, :slug
end

class Link < ApplicationRecord
  validates :category, presence: true
  validates :url, presence: true
  validates :name, presence: true
end

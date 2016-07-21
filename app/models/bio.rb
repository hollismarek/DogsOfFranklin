class Bio < ApplicationRecord
  has_many :photos
  attr_accessor :images
end

class Photo < ApplicationRecord
  belongs_to :bio

  attr_accessor :should_remove
end

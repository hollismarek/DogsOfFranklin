require 'aws-sdk'
require 'pathname'
require 'uri'

class Photo < ApplicationRecord
  belongs_to :bio
end

class Prefecture < ApplicationRecord
  has_many :guns
  has_many :municipalities
end

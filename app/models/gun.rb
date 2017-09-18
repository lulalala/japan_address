class Gun < ApplicationRecord
  belongs_to :prefecture
  has_many :municipalities
end

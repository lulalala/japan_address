class Municipality < ApplicationRecord
  belongs_to :prefecture
  belongs_to :gun
  has_many :sub_municipalities
end

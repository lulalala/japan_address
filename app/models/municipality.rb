class Municipality < ApplicationRecord
  belongs_to :prefecture
  belongs_to :gun
end

class Gender < ApplicationRecord
  has_many :categories

  validates :name,  presence: true
  validates :name_tm,  presence: true
end

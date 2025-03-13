class Category < ApplicationRecord
  belongs_to :gender

  validates :name,  presence: true
  validates :name_tm,  presence: true
end

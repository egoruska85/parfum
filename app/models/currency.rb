class Currency < ApplicationRecord
  validates :name,  presence: true
  validates :name_tm,  presence: true
  validates :banknote,  presence: true
end

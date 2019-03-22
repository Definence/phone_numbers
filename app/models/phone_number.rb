class PhoneNumber < ApplicationRecord
  belongs_to :user

  NUMBERS_STARTS_WITH = 1111111111
  NUMBERS_END_WITH = 9999999999

  validates :number,
    numericality: {
      only_ineger: true,
      greater_than_or_equal_to: NUMBERS_STARTS_WITH,
      less_than_or_equal_to: NUMBERS_END_WITH
    },
    presence: true,
    uniqueness: true

  def self.generate_number
    rand(PhoneNumber::NUMBERS_STARTS_WITH..PhoneNumber::NUMBERS_END_WITH)
  end
end

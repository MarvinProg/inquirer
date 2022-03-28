class Hashtag < ApplicationRecord
  REGEXP_HASHTAG = /#[[:word:]-]+/.freeze

  has_many :hashtag_questions, dependent: :destroy
  has_many :questions, through: :hashtag_questions

  scope :only_have_question, -> { joins(:questions).distinct }
end

module Surveillance
  class Section < ActiveRecord::Base
    belongs_to :survey, class_name: "Surveillance::Survey",
      inverse_of: :sections

    has_many :questions, -> { ordered }, as: :parent,
      class_name: "Surveillance::Question", dependent: :destroy,
      inverse_of: :parent
    accepts_nested_attributes_for :questions

    validates_presence_of :title, :position

    scope :includes_all, -> { includes(questions: :questions) }
    scope :ordered, -> { order("surveillance_sections.position ASC") }
  end
end

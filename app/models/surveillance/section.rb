module Surveillance
  class Section < ActiveRecord::Base
    # include Sortable
    # sortable parent: :project

    belongs_to :survey, class_name: "Surveillance::Survey",
      inverse_of: :sections

    has_many :questions, as: :parent, class_name: "Surveillance::Question",
      dependent: :destroy, order: "surveillance_questions.position ASC",
      inverse_of: :parent

    validates_presence_of :title, :position

    scope :includes_all, -> { includes(questions: :questions) }
  end
end
module Surveillance
  class Question < ActiveRecord::Base
    include Surveillance::Field

    has_many :questions, as: :parent, class_name: "Surveillance::Question",
      inverse_of: :parent
    accepts_nested_attributes_for :questions, allow_destroy: true

    belongs_to :parent, polymorphic: true, inverse_of: :questions

    has_many :options, class_name: "Surveillance::Option", dependent: :destroy
    accepts_nested_attributes_for :options, allow_destroy: :true

    has_many :answers, class_name: "Surveillance::Answer", dependent: :destroy

    has_many :settings, class_name: "Surveillance::FieldSetting",
      dependent: :destroy
    accepts_nested_attributes_for :settings

    has_many :branch_rules, class_name: "Surveillance::BranchRule",
      dependent: :destroy, inverse_of: :question
    accepts_nested_attributes_for :branch_rules, allow_destroy: :true

    validates_presence_of :title

    delegate :survey, to: :parent

    scope :ordered, -> { order("surveillance_questions.position ASC") }

    def matching_rule_for answer
      branch_rules.find { |rule| rule.matches?(answer) }
    end

    def section
      parent_type == "Surveillance::Question" ? parent.parent : parent
    end
  end
end

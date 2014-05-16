module Surveillance
  class Survey < ActiveRecord::Base
    has_many :sections, -> { ordered }, foreign_key: "survey_id",
      dependent: :destroy, inverse_of: :survey

    has_many :questions, through: :sections

    has_many :attempts, class_name: "Surveillance::Attempt",
      foreign_key: "survey_id", dependent: :destroy

    validates_presence_of :title

    scope :includes_all, -> {
      includes(
        sections: {
          questions: [:questions, :options, :settings, :branch_rules]
        }
      )
    }

    scope :published, -> { where(published: true) }

    scope :all_with_answers, -> {
      includes(
        sections: { questions: [:questions, { options: :answers} ] }
      )
    }

    def closed?
      end_date && end_date < Time.now.to_date
    end

    def attempt_from_ip ip_address
      attempts.find_by_ip_address(ip_address)
    end
  end
end

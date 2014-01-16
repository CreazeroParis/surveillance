module Surveillance
  class Survey < ActiveRecord::Base
    has_many :sections, foreign_key: "survey_id", dependent: :destroy,
      inverse_of: :survey, order: "surveillance_sections.position ASC"

    has_many :attempts, class_name: "Surveillance::Attempt",
      foreign_key: "survey_id", dependent: :destroy

    validates_presence_of :title

    scope :published, where(published: true)

    def closed?
      end_date && end_date < Time.now.to_date
    end

    def attempt_from_ip ip_address
      attempts.find_by_ip_address(ip_address)
    end
  end
end

module Surveillance
  class Survey < ActiveRecord::Base
    # include Sortable

    has_many :sections, -> { order("surveillance_sections.position ASC") }, foreign_key: "survey_id",
      dependent: :destroy, inverse_of: :survey

    has_many :attempts, class_name: "Surveillance::Attempt",
      foreign_key: "survey_id", dependent: :destroy

    # accepts_nested_attributes_for :sections

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

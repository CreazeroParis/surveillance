module Surveillance
  class Attempt < ActiveRecord::Base
    has_many :answers, class_name: "Surveillance::Answer",
      foreign_key: 'attempt_id', dependent: :destroy, inverse_of: :attempt,
      before_add: :set_attempt_on_answers

    belongs_to :survey, class_name: "Surveillance::Survey"

    accepts_nested_attributes_for :answers

    scope :includes_all, -> {
      includes(
        answers: [:question, :options, :content]
      )
    }

    before_validation do
      answers_to_delete = answers.reduce([]) do |delete, answer|
        delete << answer unless sections_to_answer[answer.question.section.id]
        delete
      end

      answers_to_delete.each { |answer| answers.delete(answer) }
    end

    def sections_to_answer
      @sections_to_answer ||= build_sections_to_answer_hash
    end

    def answer_to question
      questions_answers[question.id]
    end

    def questions_answers
      @questions_answers ||= Hash[answers.map { |a| [a.question_id, a] }]
    end

    private

    def set_attempt_on_answers answer
      answer.attempt = self
    end

    def build_sections_to_answer_hash
      @sections = survey.sections.includes(questions: [:questions, :branch_rules])
      # Prepare sections to answer hash, with each section needing to be
      # answered by default
      sections_hash = Hash[@sections.map { |section| [section.id, true] }]
      # Iterate on each section and check if a matching branching rule is found.
      # If one is found, update the sections_hash according to the rule
      @sections.each do |section|
        next if sections_hash[section.id] == false

        matching_rule = section.questions.reduce(nil) do |rule, question|
          if !rule && (answer = answer_to(question))
            rule = question.matching_rule_for(answer)
          end

          rule
        end

        if matching_rule
          sections_hash.reduce(true) do |continue, (section_id, _)|
            if continue && section.id == section_id
              continue = false
            elsif section_id == matching_rule.section_id
              break
            elsif !continue
              sections_hash[section_id] = false
            end
            continue
          end
        end
      end

      sections_hash
    end
  end
end

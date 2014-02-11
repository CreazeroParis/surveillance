module Surveillance
  module Field
    class Base
      include ActionView::Helpers::FormOptionsHelper

      attr_accessor :question
      attr_writer :answer, :attempt

      def initialize question, options = {}
        attempt = options.fetch(:attempt, nil)
        self.question = question
        self.attempt = attempt
      end

      def attempt
        @attempt || (@answer && @answer.attempt)
      end

      def answer
        @answer ||= attempt && attempt.answer_to(question)
      end

      def answer_or_initialize
        answer || Surveillance::Answer.new
      end

      def answer_or_initialize_for attempt
        self.attempt = attempt
        answer = answer_or_initialize
        answer.question = question
        answer
      end

      def choosable?
        false
      end

      def mandatory_content?
        false
      end

      def matrix?
        false
      end

      def has_sub_questions?
        false
      end

      def view_name
        "question"
      end

      def settings
        @settings ||= self.class.settings.freeze
      end

      def settings?
        settings.length > 0
      end

      def answer_string
        answer.content ? answer.content.value : ""
      end

      # Defines following partial view path methods :
      %w(form show settings overview export).each do |view|
        define_method(:"#{ view }_path") do
          "#{ self.class.name.underscore }/#{ view }"
        end
      end

      def rules_form_path
        "surveillance/field/shared/rules_form"
      end

      def validate_answer answer
        self.answer = answer

        if question.mandatory && empty?
          answer.errors[:present] << I18n.t("errors.messages.empty")
        end
      end

      def empty?
        !present?
      end

      def present?
        raise NoMethodError, "Each field type must override present? to " +
          "implement custom presence logic. " +
          "Raised from #{ self.class.name }"
      end

      def available_branch_conditions
        conditions = %w(answers doesnt_answer)
        conditions += %w(answers_option doesnt_answer_option) if choosable?
        conditions
      end

      def available_branch_actions
        %w(goto_section finalize_survey)
      end

      def options_list
        @options_list ||= question.options.each_with_index.map do |option, index|
          ["#{ index } - #{ option.title }", option.id]
        end
      end

      # Override this method to define custom before_validation callbacks to
      # be executed on the referer question model
      #
      def before_validation_callback
      end

      class << self
        attr_writer :settings

        def setting key, options = {}
          settings[key] = Surveillance::Setting.new(self, options.merge(key: key))
        end

        def settings
          @settings ||= Surveillance::SettingsCollection.new
        end

        def inherited subclass
          # Ensure settings are inherited
          subclass.settings.reverse_merge! settings
        end
      end
    end
  end
end

module Surveillance
  module Field
    extend ActiveSupport::Autoload
    extend ActiveSupport::Concern

    autoload :Base, "surveillance/field/base"
    autoload :Text, "surveillance/field/text"
    autoload :TextArea, "surveillance/field/text_area"
    autoload :SingleChoice, "surveillance/field/single_choice"
    autoload :MultipleChoices, "surveillance/field/multiple_choices"
    autoload :Matrix, "surveillance/field/matrix"
    autoload :MultipleChoicesMatrix, "surveillance/field/multiple_choices_matrix"
    autoload :MatrixChoice, "surveillance/field/matrix_choice"
    autoload :MatrixQuestion, "surveillance/field/matrix_question"
    autoload :Order, "surveillance/field/order"
    autoload :OrderQuestion, "surveillance/field/order_question"

    mattr_accessor :available_field_types
    @@available_field_types = %w(
      text text_area single_choice multiple_choices
      matrix multiple_choices_matrix order
    )

    def field attempt: nil, force_reload: false
      return @field if !force_reload && @field

      @field = (field_class).new(self, attempt: attempt)
    end

    def field_class
      Field.const_get(field_type.camelize)
    end

    def self.field_types_enum
      Surveillance.options_for(@@available_field_types, "field_types")
    end

    included do
      validates_presence_of :field_type

      after_initialize do
        self.field_type ||= "text"
      end

      before_validation :before_validation_callback
      delegate :before_validation_callback, to: :field
    end
  end
end
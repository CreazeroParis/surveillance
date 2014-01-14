module Surveillance
  module Validators
    extend ActiveSupport::Autoload

    autoload :AnswerValidator, "surveillance/validators/answer_validator"
  end
end
class Surveillance.Matrix extends Surveillance.Question
  initialize: (options) ->
    @subQuestions = []

  processValidations: ->
    errors = _.reduce(
      @subQuestions
      (errors, q) ->
        errors.push(q.id) unless q.isValid()
        errors
      []
    )

    if errors.length then errors else false
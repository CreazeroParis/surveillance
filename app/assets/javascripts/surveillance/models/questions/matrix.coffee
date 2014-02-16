class Surveillance.Matrix extends Surveillance.Question
  initialize: (options) ->
    @set(matrix: true)
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

  hasAnswered: (questionId, optionId) ->
    _.any @subQuestions, (subQuestion) ->
      subQuestion.id == questionId and subQuestion.hasAnswered(optionId)
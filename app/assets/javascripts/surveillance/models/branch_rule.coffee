class Surveillance.BranchRule extends Backbone.Model
  matches: (@question) ->
    @[@get("condition")]()

  answers: ->
    @question.answered()

  doesnt_answer: ->
    !@answers()

  answers_option: ->
    optionId = @get("option_id").toString()
    matrix = @question.get("matrix")
    questionId = @get("question_id").toString() if matrix
    _.any @question.get("fields"), (answer) =>
      if matrix
        [qId, id] = answer.split(":")
        questionId is qId and optionId is id
      else
        optionId is answer

  doesnt_answer_option: ->
    !@answers_option()

class Surveillance.BranchRule extends Backbone.Model
  matches: (@question) ->
    @[@get("condition")]()

  answers: ->
    @question.answered()

  doesnt_answer: ->
    !@answers()

  answers_option: ->
    optionId = @get("option_id")

    if @question.get("matrix")
      questionId = @get("sub_question_id")
      @question.hasAnswered(questionId, optionId)
    else
      @question.hasAnswered(optionId)

  doesnt_answer_option: ->
    !@answers_option()

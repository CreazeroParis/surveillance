class Surveillance.MatrixView extends Surveillance.QuestionView
  beforeInitialize: ->
    _.bindAll(this, "buildSubQuestions")

  processFieldValue: ($el) ->
    if $el.is(":checked")
      questionId = $el.closest("[data-sub-question-id]").data("sub-question-id")
      "#{ questionId }:#{ $el.val() }"

  getFields: ->
    super.not(".string")

  buildModel: (options) ->
    @model = new Surveillance.Matrix(options)
    @buildSubQuestions()

  buildSubQuestions: (el) ->
    _.each @$("[data-sub-question-id]"), (el) =>
      model = new Surveillance.MatrixQuestion
      new Surveillance.MatrixQuestionView(el: el, model: model)
      @model.subQuestions.push(model)

class Surveillance.MatrixView extends Surveillance.QuestionView
  processFieldValue: ($el) ->
    if $el.is(":checked")
      questionId = $el.closest("[data-sub-question-id]").data("sub-question-id")
      "#{ questionId }:#{ $el.val() }"

  getFields: ->
    super.not(".string")

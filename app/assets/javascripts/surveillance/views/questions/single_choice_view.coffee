class Surveillance.SingleChoiceView extends Surveillance.QuestionView
  processFieldValue: ($el) ->
    $el.val() if $el.is(":checked")

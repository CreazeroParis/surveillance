class Surveillance.ChoiceView extends Surveillance.QuestionView
  processFieldValue: ($el) ->
    $el.val() if $el.is(":checked")

  requiredAnswersCount: ->
    if _.include(@fieldValues(), "other") then 2 else 1

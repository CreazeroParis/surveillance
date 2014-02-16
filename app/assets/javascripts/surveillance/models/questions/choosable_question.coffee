class Surveillance.ChoosableQuestion extends Surveillance.Question
  processValidations: ->
    otherChoosed = _.include(@get("value"), "other")
    minFieldsToFill = 1
    chooseField = @get("value").length < minFieldsToFill
    fillOtherField = otherChoosed && !@get("other")

    if chooseField or fillOtherField
      { chooseField: chooseField, fillOtherField: fillOtherField }
    else
      false

  hasAnswered: (optionId) ->
    _.include(@get("value"), optionId)


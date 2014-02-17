class Surveillance.Number extends Surveillance.Question
  defaults:
    value: null

  validate: ->
    return null unless @get("required") or @get("value")
    @processValidations()

  processValidations: ->
    value = @get("value")
    belowMinimum = value and (minimum = @get("minimum")) and value < minimum
    aboveMaximum = value and (maximum = @get("maximum")) and value > maximum

    console.log "Number : ", value, belowMinimum, aboveMaximum

    !value or belowMinimum or aboveMaximum




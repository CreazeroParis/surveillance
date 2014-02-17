class Surveillance.NumberView extends Surveillance.QuestionView
  events:
    "change .spinner": "processAnswerValues"

  beforeInitialize: ->
    @$input = @$el.find("input[type=number]")

  processAnswerValues: ->
    @model.set(value: @processFieldValue())
    @cleanErrors()

  processFieldValue: ->
    (value = @$input.val()) and parseInt(value, 10)

  buildModel: (options) ->
    minimum = @$input.attr("min") and parseInt(@$input.attr("min"), 10)
    maximum = @$input.attr("max") and parseInt(@$input.attr("max"), 10)
    _.extend(options, { minimum: minimum, maximum: maximum })
    @model = new Surveillance.Number(options)
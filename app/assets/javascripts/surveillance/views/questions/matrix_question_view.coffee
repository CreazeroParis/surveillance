class Surveillance.MatrixQuestionView extends Backbone.View
  events:
    "change input[type=radio], input[type=checkbox]": "valueChanged"

  initialize: (options) ->
    @model.set(
      id: @$el.data("sub-question-id")
      value: @choiceValues()
    )

    @listenTo(@model, "invalid", @refreshErrors)

  choiceValues: ->
    _.compact(
      _.map(
        @$("input[type=radio], input[type=checkbox]")
        (input) -> ($input = $(input)).is(":checked") and $input.val()
      )
    )

  valueChanged: ->
    @model.set(value: @choiceValues())
    @$el.removeClass("danger")

  refreshErrors: ->
    @$el.addClass("danger") if @model.validationError

class Surveillance.ChoiceView extends Surveillance.QuestionView
  events:
    "change input[type=radio], input[type=checkbox]": "valueChanged"
    "change .other-field input[type=text]": "otherChanged"
    "change select": "selectValueChanged"

  choiceValues: ->
    if ($select = @$("select")).length
      $select.val() || null
    else
      _.compact(
        _.map(
          @$("input[type=radio], input[type=checkbox]")
          (input) -> ($input = $(input)).is(":checked") and $input.val()
        )
      )

  otherValue: ->
    @$(".other-field input[type=text]").val() || null

  valueChanged: ->
    @model.set(value: @choiceValues())
    @cleanErrors()

  otherChanged: ->
    @model.set(other: @otherValue())
    @cleanErrors()

  selectValueChanged: ->
    @model.set(value: @$("select").val())
    @cleanErrors()

  cleanErrors: ->
    @$el.removeClass("has-error")
    @$(".has-error").removeClass("has-error")

  requiredAnswersCount: ->
    if _.include(@fieldValues(), "other") then 2 else 1

  buildModel: (options) ->
    @model = new Surveillance.ChoosableQuestion(
      _.extend(options, { value: @choiceValues(), other: @otherValue() })
    )

  refreshErrors: ->
    console.log @model.validationError
    if @model.validationError.chooseField
      @$(".form-group").addClass("has-error")

    if @model.validationError.fillOtherField
      @$(".other-field .form-group").addClass("has-error")
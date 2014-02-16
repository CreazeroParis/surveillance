class Surveillance.ChoiceView extends Surveillance.QuestionView
  events:
    "change input[type=radio], input[type=checkbox]": "valueChanged"
    "change .other-field input[type=text]": "otherChanged"
    "change select": "selectValueChanged"

  beforeInitialize: ->
    _.bindAll(this, "valueFor")

  choiceValues: ->
    if ($select = @$("select")).length
      $select.val() || null
    else
      _.compact(_.map(@$("input[type=radio], input[type=checkbox]"), @valueFor))

  valueFor: (input) ->
    ($input = $(input)).is(":checked") and (val = $input.val()) and parseInt(val, 10)

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
    if @model.validationError.chooseField
      @$(".form-group").addClass("has-error")

    if @model.validationError.fillOtherField
      @$(".other-field .form-group").addClass("has-error")
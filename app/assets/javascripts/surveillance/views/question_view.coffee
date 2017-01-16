class Surveillance.QuestionView extends Backbone.View
  events:
    "change input, select": "processAnswerValues"

  initialize: ->
    @$fields = @getFields()

    @beforeInitialize?()

    @buildModel(required: @fieldRequired(), rules: @branchRules())

    @processAnswerValues(cleanErrors: false)

    @listenTo(@model, "invalid", @refreshErrors)

  processAnswerValues: (options = {}) ->
    fields = @fieldValues()
    answers = @requiredAnswersCount()

    @model.set(fields: fields, fieldsToFill: answers)
    @cleanErrors() unless options.cleanErrors is false

    @afterAnswerValuesProcessing?()

  fieldValues: ->
    _.compact(_.map(@$fields, (el) => @processFieldValue($(el))))

  requiredAnswersCount: ->
    _.keys(_.groupBy(@$fields, (el) -> $(el).attr("name"))).length

  processFieldValue: ($el) ->
    $el.val()

  cleanErrors: ->
    @$(".has-error").removeClass("has-error")

  refreshErrors: ->
    @$(".form-group").addClass("has-error")

  getFields: ->
    @$("input, select").not("[type=hidden]")

  isValid: ->
    @model.isValid()

  fieldRequired: ->
    @$el.data("required")

  branchRules: ->
    @$el.data("branch-rules")

  buildModel: (options) ->
    @model = new Surveillance.Question(options)

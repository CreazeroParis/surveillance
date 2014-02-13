class Surveillance.QuestionView extends Backbone.View
  events:
    "change input, select": "processAnswerValues"

  initialize: ->
    @$fields = @getFields()
    required = @$(".required").length > 0

    @model = new Surveillance.Question(
      required: required, rules: @$el.data("branch-rules")
    )

    @processAnswerValues()

    @listenTo(@model, "invalid", @refreshErrors)

  processAnswerValues: ->
    fields = _.compact _.map @$fields, (el) => @processFieldValue($(el))

    answers = _.keys(_.groupBy(@$fields, (el) -> $(el).attr("name"))).length

    @model.set(fields: fields, fieldsToFill: answers)
    @$(".control-group").removeClass("error")

    @afterAnswerValuesProcessing?()

  processFieldValue: ($el) ->
    $el.val()

  refreshErrors: ->
    @$(".control-group").addClass("error")

  getFields: ->
    @$("input, select").not("[type=hidden]")

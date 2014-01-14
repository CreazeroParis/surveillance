class Surveillance.QuestionView extends Backbone.View
  events:
    "change input, select": "processAnswerValues"

  initialize: ->
    @$fields = @$("input, select").not("[type=hidden]")
    required = @$(".required").length > 0

    @matrix = @$el.data("matrix")
    @model = new Surveillance.Question(
      required: required, rules: @$el.data("branch-rules"), matrix: @matrix
    )

    @processAnswerValues()

    @listenTo @model, "invalid", @refreshErrors

  processAnswerValues: ->
    fields = _.compact _.map @$fields, (el) =>
      if ($el = $(el)).is(":checkbox, :radio")
        if $el.is(":checked")
          if @matrix
            questionId = $el.closest("[data-sub-question-id]").data("sub-question-id")
            "#{ questionId }:#{ $el.val() }"
          else
            $el.val()
      else
        $el.val()

    answers = _.keys(_.groupBy(@$fields, (el) -> $(el).attr("name"))).length

    @model.set(fields: fields, fieldsToFill: answers)
    @$(".control-group").removeClass("error")

  refreshErrors: ->
    @$(".control-group").addClass("error")


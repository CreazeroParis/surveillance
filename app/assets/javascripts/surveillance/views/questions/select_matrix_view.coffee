class Surveillance.SelectMatrixView extends Surveillance.QuestionView
  afterAnswerValuesProcessing: ->
    @$("option[disabled]").removeAttr("disabled")

    alreadySelected = _.reduce(
      @subQuestions()
      (answered, subQuestion) ->
        if(val = subQuestion.$field.find("select").val())
          answered[subQuestion.id] = val
        answered
      {}
    )

    _.each @subQuestions(), (subQuestion) ->
      _.each alreadySelected, (val, id) ->
        if subQuestion.id isnt id
          subQuestion.$input.find("option[value='#{ val }']")
            .attr(disabled: "disabled")


  subQuestions: ->
    @$subQuestions ?= _.map(
      @$("[data-sub-question-id]")
      (el) ->
        $el = $(el)
        {
          $field: $el,
          id: $el.data("sub-question-id").toString(),
          $input: $el.find("select")
        }
    )

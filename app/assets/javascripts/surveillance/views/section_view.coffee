class Surveillance.SectionView extends Backbone.View
  events:
    "click .validate-section": "validate"
    "click .back-to-previous-section": "cancel"

  initialize: ->
    @questionViews = @$(".surveillance-question").map (i, el) ->
      new Surveillance.QuestionView(el: el)

    @id = @$el.data("id")

  validate: ->
    isValid = _.reduce(
      @questionViews,
      (valid, view) => valid and view.model.isValid()
      true
    )

    if isValid
      if (rule = @firstMatchingBranchRule())
        if (action = rule.get("action")) == "goto_section"
          @trigger("change-section", rule.get("section_id"))
        else if action == "finalize_survey"
          @trigger("submit-survey")
      else
        @trigger("validated")

  firstMatchingBranchRule: ->
    for view in @questionViews
      if (rule = view.model.firstMatchingRule())
        return rule

  cancel: ->
    @trigger("canceled")

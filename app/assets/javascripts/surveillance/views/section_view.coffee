class Surveillance.SectionView extends Backbone.View
  events:
    "click .validate-section": "validate"
    "click .validate-survey": "validate"
    "click .back-to-previous-section": "cancel"

  initialize: ->
    @questionViews = @$(".surveillance-question").map (i, el) =>
      new Surveillance[@questionViewClassFor(el)](el: el)

    @id = @$el.data("id")

  validate: (e) ->
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
      else if $(e.currentTarget).hasClass("validate-section")
        @trigger("validated")
    else
      e.preventDefault()


  firstMatchingBranchRule: ->
    for view in @questionViews
      if (rule = view.model.firstMatchingRule())
        return rule

  cancel: ->
    @trigger("canceled")

  questionViewClassFor: (el) ->
    _.reduce(
      $(el).data("view").split("-")
      (name, str) -> name + str.charAt(0).toUpperCase() + str.slice(1)
      ""
    ) + "View"

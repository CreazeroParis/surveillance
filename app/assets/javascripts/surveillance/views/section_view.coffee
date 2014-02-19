class Surveillance.SectionView extends Backbone.View
  events:
    "click .validate-section": "validate"
    "click .validate-survey": "validate"
    "click .back-to-previous-section": "cancel"

  initialize: ->
    @questionViews = @$(".surveillance-question").map (i, el) =>
      new Surveillance[@questionViewClassFor(el)](el: el)

    @id = @$el.data("id")
    @index = @$el.data("index")

  validate: (e) ->
    errors = []
    isValid = _.reduce(
      @questionViews,
      (valid, view) => valid and view.isValid()
      true
    )

    if isValid
      if (rule = @firstMatchingBranchRule())
        if (action = rule.get("action")) == "goto_section"
          @trigger("change-section", rule.get("section_id"))
          @trigger("section-complete")
        else if action == "finalize_survey"
          @trigger("submit-survey")
      else if $(e.currentTarget).hasClass("validate-section")
        @trigger("validated")
        @trigger("section-complete")
      else if $(e.currentTarget).hasClass("validate-survey")
        @trigger("submit-survey")
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

  serialize: ->
    @$("input, select").serialize() + "&section_index=#{ @index }"

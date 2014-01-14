class Surveillance.Question extends Backbone.Model
  constructor: (attrs, options) ->
    @rules = new Surveillance.BranchRuleCollection(attrs.rules)
    delete attrs.rules
    super(attrs, options)

  validate: ->
    @get("required") && @get("fields").length < @get("fieldsToFill")

  answered: ->
    @get("fields").length > 0

  firstMatchingRule: ->
    for rule in @rules.models
      return rule if rule.matches(this)
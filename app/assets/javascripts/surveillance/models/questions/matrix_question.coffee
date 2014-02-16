class Surveillance.MatrixQuestion extends Backbone.Model
  validate: ->
    @get("value").length == 0

  hasAnswered: (optionId) ->
    _.include(@get("value"), optionId)


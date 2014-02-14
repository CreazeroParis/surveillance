class Surveillance.MatrixQuestion extends Backbone.Model
  validate: ->
    @get("value").length == 0
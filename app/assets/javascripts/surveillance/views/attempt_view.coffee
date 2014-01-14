class Surveillance.AttemptView extends Backbone.View
  initialize: ->
    @sectionViews = _.map @$(".surveillance-section"), (el) =>
      section = new Surveillance.SectionView(el: el)
      @listenTo section, "validated", => @nextSection(section)
      @listenTo section, "canceled", => @previousSection(section)
      @listenTo section, "change-section", (sectionId) =>
        @changeSection(section, sectionId)
      @listenTo section, "submit-survey", => @submit()

      section

    # Fill section views with their default next and previous elements
    _.each @sectionViews, (view) =>
      view.nextSection = @nextFor(view)
      view.previousSection = @previousFor(view)

    console.log @$el

  nextSection: (view) ->
    @transition(view, view.nextSection)

  previousSection: (view) ->
    @transition(view, view.previousSection)

  changeSection: (current, nextId, mode = "next") ->
    view = @findSection(nextId)
    view.previousSection = current
    @transition(current, view)

  transition: (currentView, nextSection) ->
    currentView.$el.fadeOut 200, -> nextSection.$el.fadeIn(200)

  nextFor: (view) ->
    _.reduce(@sectionViews, @nextIterator(view), null)

  previousFor: (view) ->
    _.reduceRight(@sectionViews, @nextIterator(view), null)

  nextIterator: (view) ->
    (found, section) ->
      return section if found == "next"
      return found if found
      return "next" if section.cid == view.cid

  findSection: (id) ->
    _.find @sectionViews, (view) -> view.id == id

  submit: ->
    @$el.submit()

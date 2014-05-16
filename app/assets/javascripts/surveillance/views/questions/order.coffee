class Surveillance.OrderView extends Surveillance.QuestionView
  beforeInitialize: ->
    @$('.orderable-item').css(cursor: 'move')
    $orderField = @$(".survey-order-field").sortable
      stop: (e, ui) ->
        $orderField.find('.orderable-item').each (index, el) ->
          $(el).find(".sub-question-input").val(index)



$ ->
  $("body").on "click", "[data-destroy-field]", (e) ->
    e.preventDefault()
    $link = $(e.currentTarget)
    $link.prev().val("1")
    target = $link.data("parent-target") || "fieldset"
    $target = $link.closest(target)
    $target.fadeOut(300)

  $("body").on "click", "[data-toggle='new-field']", (e) ->
    e.preventDefault()
    $link = $(e.currentTarget)
    time = new Date().getTime()
    idReplacePattern = new RegExp($link.data("id"), "g")
    html = $link.data("fields").replace(idReplacePattern, time)
    $link.before(html)



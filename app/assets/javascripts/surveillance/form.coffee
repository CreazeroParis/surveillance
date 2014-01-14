# Create Surveillance global namespace
@Surveillance = {}

$ ->
  # Initialize forms if present on page
  if ($forms = $(".surveillance-attempt-form"))
    $forms.each (i, el) -> new Surveillance.AttemptView(el: el)

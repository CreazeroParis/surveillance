Surveillance.config do |config|
  # Choose a controller class method to be called before admin controllers
  # actions to authenticate admins
  # Setting it to nil, will let everybody access the admin panel
  #
  # Default : nil
  #
  # config.admin_authorization_method = :authenticate_user!

  # Define a layout to be used in Surveillance views
  # Setting it to nil will let the default layout
  #
  # Default : nil
  #
  # config.views_layout = "survey"

  # Register field partials to allow overriding field rendering from admin
  #
  # Don't forget to add the registered partial view in :
  #   "app/views/surveillance/field/customer/<partial_path>"
  #
  # Surveillance.partials.register "Partial Name", "partial_path"
end
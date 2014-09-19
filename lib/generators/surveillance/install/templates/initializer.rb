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

  # Change Admin base controller
  #
  # config.admin_base_controller = 'AdminController'

  # Register field partials to allow overriding field rendering from admin
  #
  # Don't forget to add the registered partial view in :
  #   "app/views/surveillance/field/customer/<partial_path>"
  #
  # config.partials.register "Partial Name", "partial_path"

  # Register a callback to be called when an attempt has already be registered
  # for an anonymous user.
  # The callback will be executed in the context of the controller, allowing you
  # to use controller methods
  # Setting it to nil will keep the default behaviour of adding a flash[:error]
  # message and redirecting to the surveys list
  #
  # Default : nil
  #
  # config.attempt_already_registered_callback = ->(attempt) {
  #   flash[:error] = "You already completed this survey"
  #   redirect_to(root_path)
  # }

  # Surveys root path used when redirecting from a survey
  # Executed in the context of the controller / view where it is called
  # Note that the controller is inside the Surveillance Engine, you need
  # to call the root on the `main_app` object if you need to redirect to
  # your app
  #
  # Default : nil
  #
  # config.surveys_root_path = -> { main_app.root_path }
end
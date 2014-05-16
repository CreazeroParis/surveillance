module Surveillance
  module Admin
    class BaseController < Surveillance.admin_base_controller.constantize
      if Surveillance.admin_base_controller != 'Surveillance::ApplicationController'
        include Surveillance::BaseControllerConcern
        include Surveillance::ApplicationHelper
        helper Surveillance::ApplicationHelper
      end

      if Surveillance.admin_authorization_method
        before_filter Surveillance.admin_authorization_method
      end
    end
  end
end

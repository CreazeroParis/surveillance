module Surveillance
  module Admin
    class BaseController < Surveillance::ApplicationController
      if Surveillance.admin_authorization_method
        before_filter Surveillance.admin_authorization_method
      end
    end
  end
end

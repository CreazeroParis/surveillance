module Surveillance
  class ApplicationController < ::ApplicationController
    include Surveillance::BaseControllerConcern

    layout Surveillance.views_layout if Surveillance.views_layout
  end
end

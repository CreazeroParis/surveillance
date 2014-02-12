require "decent_exposure"
require "haml-rails"
require "jquery-rails"
require "simple_form"
require "spreadsheet_on_rails"

module Surveillance
  class Engine < ::Rails::Engine
    isolate_namespace Surveillance
  end
end

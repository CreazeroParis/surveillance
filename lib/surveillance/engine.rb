module Surveillance
  class Engine < ::Rails::Engine
    isolate_namespace Surveillance

    config.to_prepare do
      path = Rails.root.join('lib', 'decorators', 'surveillance', '**', '*.rb')

      Dir[path].each do |file|
        load file
      end
    end
  end
end

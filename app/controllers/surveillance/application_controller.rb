module Surveillance
  class ApplicationController < ::ApplicationController
    decent_configuration do
      if defined?(StrongParameters)
        strategy DecentExposure::StrongParametersStrategy
      end
    end

    protected

    def flash_message type
      I18n.t("flashes.#{ flash_key }.#{ params[:action] }.#{ type }")
    end

    def flash_key
      @flash_key ||= self.class.name.underscore.gsub(/_controller$/, "")
    end

    def stong_parameters?
      defined?(StrongParameters)
    end
  end
end

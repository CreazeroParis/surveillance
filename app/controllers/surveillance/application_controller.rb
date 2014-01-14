module Surveillance
  class ApplicationController < ActionController::Base
    decent_configuration do
      strategy DecentExposure::StrongParametersStrategy
    end

    protected

    def flash_message type
      I18n.t("flashes.#{ flash_key }.#{ params[:action] }.#{ type }")
    end

    def flash_key
      @flash_key ||= self.class.name.underscore.gsub(/_controller$/, "")
    end
  end
end

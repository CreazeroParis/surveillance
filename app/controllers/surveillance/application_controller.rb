module Surveillance
  class ApplicationController < ::ApplicationController
    decent_configuration do
      if defined?(ActiveModel::ForbiddenAttributesProtection)
        strategy DecentExposure::StrongParametersStrategy
      end
    end

    layout Surveillance.views_layout if Surveillance.views_layout

    protected

    def flash_message type
      I18n.t("flashes.#{ flash_key }.#{ params[:action] }.#{ type }")
    end

    def flash_key
      @flash_key ||= self.class.name.underscore.gsub(/_controller$/, "")
    end

    def stong_parameters?
      defined?(ActiveModel::ForbiddenAttributesProtection)
    end
  end
end

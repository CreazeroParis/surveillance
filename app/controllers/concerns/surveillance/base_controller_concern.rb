module Surveillance
  module BaseControllerConcern
    extend ActiveSupport::Concern

    included do
      decent_configuration do
        if defined?(ActiveModel::ForbiddenAttributesProtection)
          strategy DecentExposure::StrongParametersStrategy
        end
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
      defined?(ActiveModel::ForbiddenAttributesProtection)
    end

    def surveys_root_path
      if (config = Surveillance.surveys_root_path)
        instance_exec(&config)
      else
        surveys_path
      end
    end
  end
end

module Surveillance
  class Setting
    attr_accessor :klass, :key, :type, :default

    def initialize klass, key: nil, type: :string, default: nil
      self.klass = klass
      self.key = key
      self.type = type
      self.default = default
    end

    def label
      I18n.t("surveillance.settings.#{ class_name }.#{ key }.field")
    end

    def admin_label
      I18n.t("surveillance.settings.#{ class_name }.#{ key }.admin")
    end

    def class_name
      @class_name ||= klass.name.demodulize.underscore
    end
  end
end
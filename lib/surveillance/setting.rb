module Surveillance
  class Setting
    attr_accessor :klass, :key, :type, :default

    def initialize klass, options = {}
      self.klass = klass
      self.key = options.fetch(:key, nil)
      self.type = options.fetch(:type, :string)
      self.default = options.fetch(:default, nil)
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
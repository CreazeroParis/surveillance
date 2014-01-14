require "surveillance/engine"

module Surveillance
  extend ActiveSupport::Autoload

  autoload :Field, "surveillance/field"
  autoload :SettingsCollection, "surveillance/settings_collection"
  autoload :Setting, "surveillance/setting"
  autoload :Validators, "surveillance/validators"

  class << self
    def table_name_prefix
      'surveillance_'
    end

    def options_for ary, key
      ary.map do |item|
        str = item.to_s
        [I18n.t("surveillance.#{ key }.#{ str }"), str]
      end
    end
  end
end

require "surveillance/engine"

module Surveillance
  extend ActiveSupport::Autoload

  autoload :Field, "surveillance/field"
  autoload :PartialsCollection, "surveillance/partials_collection"
  autoload :SettingsCollection, "surveillance/settings_collection"
  autoload :Setting, "surveillance/setting"
  autoload :Validators, "surveillance/validators"

  # Defines an autorization method to be called before actions in admin
  # controllers to authenticate admin users
  #
  mattr_accessor :admin_authorization_method
  @@admin_authorization_method = nil

  mattr_accessor :admin_base_controller
  @@admin_base_controller = 'Surveillance::ApplicationController'

  mattr_accessor :views_layout
  @@views_layout = nil

  mattr_accessor :partials
  @@partials = Surveillance::PartialsCollection.new

  mattr_accessor :attempt_already_registered_callback
  @@attempt_already_registered_callback = nil

  mattr_accessor :surveys_root_path
  @@surveys_root_path = nil

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

    def config &block
      yield self
    end

    def unique_token
      (Time.now.to_f * (100 ** 10)).to_i.to_s(36) +
        (rand * 10 ** 10).to_i.to_s(36)
    end
  end
end

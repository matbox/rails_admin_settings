# coding: utf-8
module RailsAdminSettings
  class Setting
    include ::Mongoid::Document
    include ::Mongoid::Timestamps::Short

    store_in collection: "rails_admin_settings"

    if Object.const_defined?('Mongoid') && Mongoid.const_defined?('Audit')
      include ::Mongoid::Audit::Trackable
      track_history track_create: true, track_destroy: true
    end
    
    field :enabled, type: Mongoid::VERSION.to_i < 4 ? Boolean : Mongoid::Boolean, default: true
    scope :enabled, where(enabled: true)

    field :type, type: String, default: RailsAdminSettings.types.first

    field :key, type: String
    field :raw, type: String, default: ''
    field :label, type: String

    include RailsAdminSettings::RequireHelpers
    include RailsAdminSettings::Processing
    include RailsAdminSettings::Uploads
    include RailsAdminSettings::Validation

    def disabled?
      !enabled
    end

    def enabled?
      enabled
    end

    before_save do
      self.label = self.key  unless self.label.present?
    end

    index(key: 1)

    if Object.const_defined?('RailsAdmin')
      include RailsAdminSettings::RailsAdminConfig
    else
      puts "[rails_admin_settings] Rails Admin not detected -- put this gem after rails_admin in gemfile"
    end
  end
end

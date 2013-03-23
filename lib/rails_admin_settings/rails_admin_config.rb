module RailsAdminSettings
  module RailsAdminConfig
    def self.included(base)
      if base.respond_to?(:rails_admin)
        base.rails_admin do
          navigation_label I18n.t('admin.settings.label')

          object_label_method do
            :key
          end

          list do
            if Object.const_defined?('RailsAdminToggleable')
              field :enabled, :toggle
            else
              field :enabled
            end
            field :key
            field :type
          end

          edit do
            field :enabled
            field :key do
              read_only true
              help false
            end
            field :type do
              read_only true
              help false
            end
            field :raw do
              partial "setting_value"
            end
          end
        end
      else
        puts "[rails_admin_settings] Problem: model does not respond to rails_admin: this should not happen"
      end
    end
  end
end

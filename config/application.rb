require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AutumnJRailsCommunityLibrary
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # HEADS UP! i18n 1.1 changed fallbacks to exclude default locale.
    # But that may break your application.

    # Please check your Rails app for 'config.i18n.fallbacks = true'.
    # If you're using I18n (>= 1.1.0) and Rails (< 5.2.2), this should be
    # 'config.i18n.fallbacks = [I18n.default_locale]'.
    # If not, fallbacks will be broken in your app by I18n 1.1.x.

    # For more info see:
    # https://github.com/svenfuchs/i18n/releases/tag/v1.1.0

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
  end
end

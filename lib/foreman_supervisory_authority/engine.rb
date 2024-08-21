# frozen_string_literal: true

require 'elastic-apm'

module ForemanSupervisoryAuthority
  class Engine < ::Rails::Engine
    engine_name 'foreman_supervisory_authority'

    config.autoload_paths += Dir["#{config.root}/app/controllers/concerns"]

    initializer 'foreman_supervisory_authority.register_plugin', before: :finisher_hook do
      Foreman::Plugin.register :foreman_supervisory_authority do
        requires_foreman '>= 3.10'
      end
    end

    config.elastic_apm.disable_instrumentations = %w[json]

    # map user context methods to what we use in Foreman
    config.elastic_apm.current_user_email_method = :mail
    config.elastic_apm.current_user_username_method = :login

    config.elastic_apm.merge!(SETTINGS[:foreman_supervisory_authority]) if SETTINGS[:foreman_supervisory_authority]

    # Include concerns in this config.to_prepare block
    config.to_prepare do
      ::ApplicationController.include ForemanSupervisoryAuthority::SetElasticApmContext
      ::Api::BaseController.include ForemanSupervisoryAuthority::SetElasticApmContext
      ::Api::GraphqlController.include ForemanSupervisoryAuthority::SetElasticApmContext
    rescue StandardError => e
      Rails.logger.warn "ForemanSupervisoryAuthority: skipping engine hook (#{e})"
    end
  end

  def self.with_settings?
    Setting.table_exists?
  rescue StandardError
    false
  end
end

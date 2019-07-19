# frozen_string_literal: true

require 'elastic-apm'

module ForemanSupervisoryAuthority
  class Engine < ::Rails::Engine
    engine_name 'foreman_supervisory_authority'

    config.autoload_paths += Dir["#{config.root}/app/controllers/concerns"]

    initializer 'foreman_supervisory_authority.register_plugin', before: :finisher_hook do
      Foreman::Plugin.register :foreman_supervisory_authority do
        requires_foreman '>= 1.20'
      end
    end

    # we need to disable the 'net_http' spy, see
    # https://github.com/elastic/apm-agent-ruby/issues/379
    # for reasoning
    config.elastic_apm.disabled_spies = %w[json net_http]

    # map user context methods to what we use in Foreman
    config.elastic_apm.current_user_email_method = :mail
    config.elastic_apm.current_user_username_method = :login

    config.elastic_apm.merge!(SETTINGS[:foreman_supervisory_authoriy]) if SETTINGS[:foreman_supervisory_authoriy]

    # Include concerns in this config.to_prepare block
    config.to_prepare do
      begin
        ::ApplicationController.send(:include, ForemanSupervisoryAuthority::SetElasticApmContext)
        ::Api::BaseController.send(:include, ForemanSupervisoryAuthority::SetElasticApmContext)
        ::Api::GraphqlController.send(:include, ForemanSupervisoryAuthority::SetElasticApmContext) if defined?(::Api::GraphqlController)
      rescue StandardError => e
        Rails.logger.warn "ForemanSupervisoryAuthority: skipping engine hook (#{e})"
      end
    end
  end

  def self.with_settings?
    Setting.table_exists?
  rescue StandardError
    false
  end
end

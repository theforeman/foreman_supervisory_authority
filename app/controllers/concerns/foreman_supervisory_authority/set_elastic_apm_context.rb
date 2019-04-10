# frozen_string_literal: true

module ForemanSupervisoryAuthority
  module SetElasticApmContext
    extend ActiveSupport::Concern

    included do
      before_action :set_elastic_apm_context
    end

    private

    def set_elastic_apm_context
      User.current && ElasticAPM.set_user(User.current)
    end
  end
end

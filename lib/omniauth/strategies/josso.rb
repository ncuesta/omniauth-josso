require 'omniauth'
require 'omniauth/strategy'
require 'savon'

module OmniAuth
  module Strategies
    class Josso
      include OmniAuth::Strategy

      args [:endpoint_url]

      option :endpoint_url, nil

      def request_phase
        [
          302,
          { 'Location' => "#{options.endpoint_url}/josso/signon/login.do?josso_back_to=#{callback_url}" },
          []
        ]
      end

      uid { agent.user.first[:name] }

      info do
        {
          nickname: agent.user[0][:name],
          name: agent.user.detect { |i| i[:name] == 'user.description' }[:value]
        }
      end

      extra do
        {
          roles: agent.roles
        }
      end

      def agent
        @agent ||= Agent.new options.endpoint_url, request.params['josso_assertion_id']
      end

      class Agent
        def initialize(endpoint_url, josso_assertion_id)
          @endpoint_url = endpoint_url
          @josso_assertion_id = josso_assertion_id
        end

        def identity_manager
          @identity_manager ||= Savon.client wsdl: "#{@endpoint_url}/josso/services/SSOIdentityManager?wsdl", soap_version: 1, ssl_verify_mode: :none
        end

        def identity_provider
          @identity_provider ||= Savon.client wsdl: "#{@endpoint_url}/josso/services/SSOIdentityProvider?wsdl", soap_version: 1, ssl_verify_mode: :none
        end

        def session_id
          @session_id ||= begin
            res = identity_provider.call :resolve_authentication_assertion, message: { 'in0' => @josso_assertion_id }
            res.to_hash[:resolve_authentication_assertion_response][:resolve_authentication_assertion_return]
          end
        end

        def user
          @user ||= begin
            res = identity_manager.call :find_user_in_session, message: { 'in0' => session_id }
            res.to_hash[:multi_ref]
          end
        end

        def roles
          @roles ||= begin
            res = identity_manager.call :find_roles_by_username, message: { 'in0' => user.first[:name] }
            res.to_hash[:multi_ref].map { |h| h[:name] }
          end
        end
      end
    end
  end
end

require 'typhoeus'

module Integrations
  module Rito
    class RitoGateway

      def initialize(overrides = {})
        @http_requester = overrides.fetch(:http_requester) { Typhoeus::Request }

        # TODO: Put base_url in environment variable
        @rito_base_url = overrides.fetch(:base_url) { 'https://api.lolesports.com/api' }
      end

      def get(path:, options:)
        handle_response do
          @http_requester.new(
            "#{@rito_base_url}/#{path}",
            method: :get,
            params: options,
            headers: { "Content-Type" => "application/json" }
            )
        end.body
      end

      private

      def handle_response
        request = yield

        request.on_complete do |response|
          return response if response.success?

          fail Class.new(::StandardError), response.code
        end

        request.run
      end
    end
  end
end

require 'faraday'
require 'proto_client/endpoint'

module ProtoClient
  ##
  # The class that all others should inherit from in order to pull in
  # functionality.
  class Base
    ALLOWED_METHODS = [:find, :all, :where]

    class << self
      # Handles setting up the API endpoint's base uri
      # @param url [String] the uri string
      # @param options [Hash] a hash of other options.
      def service(url, **options)
        @connection = Faraday.new(url: url) do |faraday|
          faraday.request  :url_encoded             # form-encode POST params
          faraday.response :logger                  # log requests to STDOUT
          faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        end
      end

      # Creates a specific endpiont tied to one of the Retrieval methods.
      # @param type [Symbol] a symbol of the retrieval method this endpoint
      #   maps to.
      # @param path [#to_s] the path of the endpoint. This path should be of the
      #   the format '/resource/:resource_id/some-other-resource/:id'
      # @param verb [Symbol] symbol of the HTTP verb to use. Defaults to :get
      def endpoint(type, path, verb = :get)
        # raise 'Already defined this endpoint' if @methods[type.to_sym]
        raise 'Not a valid access type' unless ALLOWED_METHODS.include? type

        e = Endpoint.new(path, verb)
        @methods[]
      end

      # Retrieves the connection defined for this api.
      # @return [Faraday::Connection] the connection defined for the class
      # @raise [StandardError] no connection was found
      def connection
        return @connection if @connection

        next_up = self.superclass

        loop do
          break if next_up == ProtoClient::Base || conn
          conn = next_up.connection if ProtoClient::Base.sub_classes.include? next_up
          next_up = next_up.superclass
        end

        conn ? (@connection = conn) : raise 'No connection found'
      end

      def find

      end

      # Registers any subclasses of Base to keep track of who has connections
      def included(klass)
        @sub_classes ||= []
        @sub_classes << klass
      end

      attr_reader :sub_classes
    end
  end
end

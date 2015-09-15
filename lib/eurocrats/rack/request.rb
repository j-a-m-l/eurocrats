module Eurocrats

  # FIXME
  class TestLocationError < StandardError; end

  # This module accessor is only useful for mocking the IP location evidence, that
  # is captured in `Rack::Request#eurocrats` when that IP address is local.
  # Something like `Eurocrats.test_location = { country_code: 'US' }` could be
  # enough in most cases.
  mattr_accessor :test_location

  module Rack
    module Request

      # This method instantiates an Eurocrat::Context the first time is invoked.
      #
      # It uses Geocoder `safe_location` for geo-locating the request IP address.
      # Then, that location is added as an evidence ('ip_location') to the context.
      # In case the IP is a loopback address, it uses `Eurocrats.test_location`
      # instead, so it should usually be configured for testing or developing purposes.
      def eurocrats supplier=nil, customer=nil
        @eurocrats ||= begin
          context = Eurocrats::Context.new supplier, customer

          context['ip_location'] = if Geocoder::IpAddress.new(ip).loopback?
            Eurocrats.test_location or raise Eurocrats::TestLocationError.new '`Eurocrats.test_location` is not set'
          else
            safe_location
          end

          context
        end
      end

    end
  end
end

if defined?(Rack) and defined?(Rack::Request)
  Rack::Request.send :include, Eurocrats::Rack::Request
end

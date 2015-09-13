module Eurocrats
  module Rack
    module Request

      # TODO arguments
      # TODO docs
      # It uses Geocoder `safe_location`
      # ip_lookup option
      def eurocrats supplier=nil, customer=nil
        @eurocrats ||= begin
          context = Eurocrats::Context.new supplier, customer

          # TODO configurable for testing
          if safe_location.country == 'Reserved'
            context['eurocrats.request.ip_location'] = 'PT'
          else
            context['eurocrats.request.ip_location'] = safe_location
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

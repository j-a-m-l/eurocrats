module Eurocrats
  module Rack
    module Request

      # TODO arguments
      def eurocrats supplier=nil, customer=nil
        @eurocrats ||= begin
          context = Eurocrats::Context.new 
          # TODO configurable
          context['eurocrats.request.ip_location'] = safe_location
          context
        end
      end

    end
  end
end

if defined?(Rack) and defined?(Rack::Request)
  Rack::Request.send :include, Eurocrats::Rack::Request
end

module Eurocrats
  # TODO better name
  module Eurocratable
    extend ActiveSupport::Concern

    # This method returns an Eurocrats::Context
    #
    # It is configured with the configured default supplier
    #
    # It includes the IP country as evidence (from the Rack::Request object)
    def eurocrats
      request.eurocrats
    end

  end
end

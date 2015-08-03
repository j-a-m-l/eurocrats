module Eurocrat
  # TODO better name
  module Eurocratable
    extend ActiveSupport::Concern

    # This method returns an Eurocrat::Context
    #
    # It is configured with the configured default supplier
    #
    # It includes the IP country as evidence (from the Rack::Request object)
    def eurocrat
      request.eurocrat
    end

  end
end

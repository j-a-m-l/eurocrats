require 'forwardable'

module Eurocrats
  module Cache
    extend Forwardable

    def_delegators :@@cache, :get, :set
  end
end

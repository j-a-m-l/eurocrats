module Eurocrats

  class Error < StandardError; end

  # Tried to use methods of an Evidence that require being related to one Context,
  # because it needs its information, but that Evidence instance is not linked.
  class EvidenceWithoutContextError < Error; end

  # Something that requires n evidences matching, has been called without having
  # those n evidences matching.
  class ConflictingEvidencesError < Error; end

  # Tried to access an inexistent evidence or it has some flaws
  class InvalidEvidenceError < Error; end

  # Country code does not exist or it does not have a valid ISO 3166-1 format.
  class InvalidCountryCodeError < Error; end

  # Error while trying to perform a VIES request of any type.
  class ViesError < Error; end

  # VAT number syntax is invalid.
  class InvalidVatNumberError < Error; end

  # Warns about using the Eurocrats::Rack::Request with loopback addresses
  class TestLocationError < Error; end

end

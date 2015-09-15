module Eurocrats

  class Error < StandardError; end

  # Something that requires n evidences matching, has been called without having
  # those n evidences matching.
  class ConflictingEvidencesError < Error; end

  # Country code does not exist or it does not have a valid ISO 3166-1 format.
  class InvalidCountryCodeError < Error; end

  # Error while trying to perform a VIES request of any type.
  class ViesError < Error; end

  # VAT number syntax is invalid.
  class InvalidVatNumberError < Error; end

end

module Eurocrats

  class Error < StandardError; end

  # Something that requires n evidences matching, has been called without having
  # that n evidences matching.
  class ConflictingEvidencesError < Error; end

  class InvalidCountryCodeError < Error; end

  class ViesError < Error; end

  # VAT number syntax is invalid
  class InvalidVatNumberError < Error; end

end

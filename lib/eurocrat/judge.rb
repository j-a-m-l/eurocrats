module Eurocrat

  # Yeah, for judging evidences
  #
  # This class compares the collected evidences and emits a verdict
  # That verdict is the location (ISO 3166-1 alpha-2 country code) of the customer
  # (https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)
  #
  # The default strategy is to find 2 evidences with the same country code
  #
  # Overriding the `conflicts` method is enough for creating a custom strategy,
  # like ignoring evidences on some conditions or requiring more than 2 evidences
  # 
  class Judge

    def verdict customer
      conflicts(customer.evidences).any?
    end

    def conflicts evidences
      evidences.reduce({}) do |conflicts, evidence|
        unless evidence
          conflicts.merge evidence
        end
      end
    end

  end

end

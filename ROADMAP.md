# ROADMAP

This is a proposal and should not be interpreted literally. If you want to collaborate in some feature before its version, do it.

## 3.0.0

 * SMS facility for capturing phone evidences with its Rails controller.

## 2.0.0

This version should add some tools for invoicing, like:

 * Providing a strategy or list of invoicing rules for each country.
 * Database / CSV to SAF-MOSS XML converter or something like that.

This version should deal with all the VAT corner cases, like:

 * VAT thresholds by country?
 * VAT for autonomous regions.
 * Special VAT rates.
 * Custom VAT exemptions.

Other possible improvements:

 * Rake task for downloading currency exchanges.

## 1.0.0

This version should include a full API review and small improvements like:

 * Allow returning additional data, like address or company type, in `VATNumberValidationsController#show`.
 * Improve controller security limiting petitions, adding delays or things like that?
 * Return error code and messages, and optionally log them, on VIES validations.
 * `eurocrats` method for Rails controllers.
 * `Strategy` class that encapsulates payment algorithms?

Other ideas:
 * Add "method access" (`evidences.lol_address`) along hash syntax (`evidences["lol_address"]`) to evidences.

## 0.9.0

 * Handle future VAT rates changes automatically.
 * VAT rates for previous dates.
 * Document and improve the Rake tasks that generates data.
 * Special (possibly non computable) evidences (without country code) like "Not in US".

## 0.8.0

 * Basic cache.
 * Configurable cache.
 * Cache geo-locations.
 * Cache VIES requests.
 * Save automatically updated VAT rates to a file.
 * Load automatically updated VAT rates from a file into cache.

## 0.7.0

 * Published to RubyGems.org.
 * More tests.
 * Fully documented with RDoc.
 * Configurable connection timeouts.
 * Mention the `VATNumberValidationsController` in the README.
 * Explain the examples in the README.
 * Document in the README how to use the exchange features.

## 0.6.0

 * Persist contexts, evidences and VIES validations?
 * Example with ad hoc Supplier and Customer classes.
 * Integrate the `valvat` VAT number validator.
 * Capture evidences from a class that includes `Evidentiable`

## 0.5.0

 * Integrate the exchanging features into `Context`.
 * Money and Numeric objects exchange from one currency to others.
 * Method for getting all the exchange rates from one currency to others.
 * Exchange examples.
 * Use `BigDecimal` for calculations.
 * `Context#evidences[...] = ...` should behave like `Context#[...] = ...`.
 * Create a `VatRate` object?
 * Configurable global default VAT rate in `Eurocrats`
 * Configurable global default number of minimum evidences in `Eurocrats`.

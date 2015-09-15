# ROADMAP

This is a proposal and should not be interpreted literally. If you want to collaborate in some feature before its version, do it.

## 3.0.0

 * SMS facility for capturing phone evidences with its Rails controller.

## 2.0.0

This version should deal with all the VAT corner cases, like:

 * VAT exemptions.
 * VAT thresholds by country.
 * VAT for autonomous regions.
 * Special VAT rates.
 * VAT rates for previous dates.

Other possible improvements:

 * Rake task for downloading currency exchanges.

## 1.0.0

This version should include a full API review and small improvements like:

 * `Context#evidences[...] = ...` should behave like `Context#[...] = ...`.
 * Configurable default rate in `Eurocrats` or in `Context` instances.
 * Configurable number of minimum evidences in `Context` instances.
 * Allow returning additional data, like address or company type, in `VATNumberValidationsController#show`.
 * Improve controller security limiting petitions, adding delays or things like that?
 * Return error code and messages, and optionally log them, on VIES validations.
* `eurocrats` method for Rails controllers.

## 0.9.0

This version should add some tools for invoicing, like:

 * Providing a strategy or list of invoicing rules for each country.
 * Database / CSV to SAF-MOSS XML converter or something like that.

## 0.8.0

 * Special (possibly non computable) evidences (without country code) like "Not in US".
 * Basic cache.
 * Configurable cache.
 * Cache geo-locations.
 * Cache VIES requests.

## 0.7.0

 * Published to RubyGems.org.
 * More tests.
 * Fully documented with RDoc.
 * Configurable connection timeouts.

## 0.6.0

 * Persist contexts, evidences and VIES validations?
 * Handle future VAT rates changes automatically.
 * Document and improve the Rake tasks that generates data.

## 0.5.0

 * Integrate the exchange features into Eurocrats::Context.
 * Money and Numeric objects exchange from one currency to others.
 * Method for getting all the exchange rates from one currency to others.
 * Save updates rates to a file.
 * Load updates rates from a file.
 * Document in the README how to use the exchange features.
 * Exchange examples.

## 0.4.0

 * Fix some Eurocrats methods.
 * Complex example of using Context for collecting money.
 * Example with ad hoc Supplier and Customer classes.
 * Example of using Context for listing prices with VAT for a specific user.
 * Mention the `VATNumberValidationsController` in the README.

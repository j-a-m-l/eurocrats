# ROADMAP

This is a proposal and should not be interpreted literally. If you want to collaborate in some feature before its version, do it.

## 3.0.0

 * SMS facility for capturing phone evidences with its Rails controller

## 2.0.0

This version should deal with all the VAT corner cases, like:

 * VAT exemptions
 * VAT thresholds by country
 * VAT for autonomous regions
 * Special VAT rates
 * VAT rates for previous dates

Other possible improvements:

 * Rake task for downloading currency exchanges

## 1.0.0

This version should include a full API review and change things like:

 * `Context#evidences[...] = ...` behaves like `Context#[...] = ...`

## 0.9.0

This version should add some tools for invoicing, like:

 * Providing a strategy or list of invoicing rules for each country
 * Database / CSV to SAF-MOSS XML converter or something like that

## 0.8.0

 * Special (possibly non computable) evidences (without country code) like "Not in US"
 * Basic cache
 * Configurable cache
 * Cache geo-locations
 * Cache VIES requests

## 0.7.0

 * Published to RubyGems.org
 * More tests
 * Fully documented with RDoc
 * Configurable connection timeouts

## 0.6.0

 * Handle future VAT rates changes automatically

## 0.5.0

 * Persist contexts, evidences and VIES validations
 * Examples of how to use the contexts, evidences, etc.

## 0.4.0

 * Currency conversion
 * Currency exchange Rails controller

## 0.3.0

 * Configurable default rate
 * `eurocrats` method for Rails controllers
 * Options for testing local Rack requests
 * `VATNumbersController` responses
 * VAT number validation routes to `VATNumbersController`

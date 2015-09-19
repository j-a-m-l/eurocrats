# CHANGELOG

## 0.4.2 (2015-09-19) Juan A. Martín Lucas <eurocrats@jaml.site>

 * Rename `Context#taxables?` to `Context#taxable_persons?` and add it some tests.
 * Add some tests to `Context#non_conflicting_location_evidences?` method.
 * Add some tests to `Context#conflicting_location_evidences?` method.

## 0.4.1 (2015-09-19) Juan A. Martín Lucas <eurocrats@jaml.site>

 * Implement `Context#conflicting_location_evidences` method.
 * Add some tests to `Context#evidenced_country` method.

## 0.4.0 (2015-09-17) Juan A. Martín Lucas <eurocrats@jaml.site>

 * Update the examples.
 * Remove several `Context` methods that provide functionality that could be used through other methods, like `evidence` or `evidenced_country`.
 * Add some pending tests to `Context`.
 * Fix `VatNumber#country_code` reader.
 * Configurable default rate in `Eurocrats` or in `Context` instances.
 * Configurable number of minimum evidences in `Context` instances.
 * Change the initialization of `Context` for admitting options,
 * Add `vat_rates_in` and `in_european_union?` class methods to `Country`, and some aliases, and use `ISO3166::Country` as its parent class, so now has much more functionality.
 * Add `vat_for_current_context` and `calculate_vat_for` methods to `Evidence` for evaluating the corresponding VAT inside a `Context`.
 * Add a new `evidence` method to `Context`.

## 0.3.6 (2015-09-16) Juan A. Martín Lucas <eurocrats@jaml.site>

 * Add functionality to the `Evidence` class (`country` and `vat_rates` methods).

## 0.3.5 (2015-09-16) Juan A. Martín Lucas <eurocrats@jaml.site>

 * Example of using `Context` for listing prices with VAT for a specific user.
 * Fix the collecting money examples

## 0.3.4 (2015-09-15) Juan A. Martín Lucas <eurocrats@jaml.site>

 * Rename 'eurocrats.request.ip_location' evidence to 'ip_location'.
 * Move `TestLocationError` to `lib/eurocrats/error.rb` and change its parent to `Eurocrats::Error`.

## 0.3.3 (2015-09-15) Juan A. Martín Lucas <eurocrats@jaml.site>

 * Add 2 complex examples of using `Context` for collecting money.

## 0.3.2 (2015-09-15) Juan A. Martín Lucas <eurocrats@jaml.site>

 * All exceptions inherit from `Eurocrats::Error`.
 * Add `jbuilder` in the Gemfile again, so Rails loads it for rendering JSON.
 * Rename `Eurocrats::VatNumber::InvalidError` to `Eurocrats::InvalidVatNumberError`.
 * Replace `Eurocrats::UnavailableCountryCodeError` `Eurocrats::InvalidVatNumberError`.

## 0.3.1 (2015-09-15) Juan A. Martín Lucas <eurocrats@jaml.site>

 * Add `money` as dependency.
 * Add `eu_central_bank` as dependency.
 * Add a simple example of using `Context` for collecting money.
 * Initialize a `Customer` with its VAT number.

## 0.3.0 (2015-09-14) Juan A. Martín Lucas <eurocrats@jaml.site>

 * Document in the README the way `request.eurocrats` works.
 * Option for mocking local Rack request IP locations.
 * Tests for `Eurocrats::Rack::Request`.

## 0.2.4 (2015-09-13) Juan A. Martín Lucas <eurocrats@jaml.site>

 * Use the default supplier for validating VAT numbers in `VATNumberValidationsController#show`.
 * Add more tests to `VATNumberValidationsController#show`.
 * Change VAT number validation URL to '/vat-number-validations/:vat_number'.
 * Rename `VATNumbersController` to `VATNumberValidationsController`.

## 0.2.3 (2015-09-13) Juan A. Martín Lucas <eurocrats@jaml.site>

 * Configurable default supplier.
 * Import default supplier data from a Hash.
 * Override `#==` for comparing different `VatNumber` instances with the same VAT number.

## 0.2.2 (2015-09-09) Juan A. Martín Lucas <eurocrats@jaml.site>

 * Document the most stable code.

## 0.2.1 (2015-09-05) Juan A. Martín Lucas <eurocrats@jaml.site>

 * Add and configure SimpleCov (code coverage tool).

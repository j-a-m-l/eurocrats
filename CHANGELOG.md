# CHANGELOG

## 0.3.0 (2015-09-14) Juan A. Martín Lucas <eurocrats@jaml.site>

 * Document in the README the way `request.eurocrats` works.
 * Option for mocking local Rack request IP locations
 * Tests for Eurocrats::Rack::Request

## 0.2.4 (2015-09-13) Juan A. Martín Lucas <eurocrats@jaml.site>

 * Use the default supplier for validating VAT numbers in `VATNumberValidationsController#show`
 * Add more tests to `VATNumberValidationsController#show`
 * Change VAT number validation URL to '/vat-number-validations/:vat_number'
 * Rename `VATNumbersController` to `VATNumberValidationsController`

## 0.2.3 (2015-09-13) Juan A. Martín Lucas <eurocrats@jaml.site>

 * Configurable default supplier
 * Import default supplier data from a Hash
 * Override `#==` for comparing different `VatNumber` instances with the same VAT number

## 0.2.2 (2015-09-09) Juan A. Martín Lucas <eurocrats@jaml.site>

 * Document the most stable code

## 0.2.1 (2015-09-05) Juan A. Martín Lucas <eurocrats@jaml.site>

 * Add and configure SimpleCov (code coverage tool)

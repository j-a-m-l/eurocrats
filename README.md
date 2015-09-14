[![Build Status](TODO)

Eurocrats
=========
Eurocrats is a Ruby library for dealing with the European VAT, although could be used in Rails as an engine.

Features
========
Currently it includes these tools:

 * User location resolution based on evidences
 * VAT calculation
 * European VAT number validator (through [valvat](https://github.com/yolk/valvat/))
 * IP geo-location (through [Geocoder](https://github.com/alexreisner/geocoder/))

Next:

 * Exchange (through [Money](https://github.com/RubyMoney/money))


Installation
============
 * This gem is not in RubyGems.org yet.

```
gem install eurocrats
```

Use
===
All the tools could be used separately, but eurocrats includes a Context class, that permits an easier and simpler interaction.

Rack::Request
-------------
Eurocrats adds `eurocrats` method to the regular Rack::Request object. This method instantiates an Eurocrats::Context the first time is invoked and establish the 'eurocrats.request.ip_location' evidence, which holds the location of the IP address.
Eurocrats depends on the [Geocoder](https://github.com/alexreisner/geocoder) gem, that also includes `location` and `safe_location` in Rack::Request. The latter is used for inferring the location of the IP address.

Testing
=======

Rack::Request
-------------
When using `request.eurocrats` in `localhost` and alike environments, `request.safe_location` could return values like `{ country: "Reserved", country_code: "RD" }`, that would provoke an Eurocrats::InvalidCountryCodeError.

`Eurocrats.test_location` provides a way to mock that location. Using something like `Eurocrats.test_location = { country_code: 'US' }` would be enough in most cases.

Other way is [configuring Geocoder for testing](https://github.com/alexreisner/geocoder#testing-apps-that-use-geocoder).

Changelog
=========

You can read previous changes in `CHANGELOG.md`.

Contributing
============

Authors
=======
Juan A. Martín Lucas (https://github.com/j-a-m-l)

License
=======
This project is licensed under the MIT license. See [LICENSE]() for details.

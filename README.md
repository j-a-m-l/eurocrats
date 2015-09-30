[![Build Status](TODO)

Eurocrats
=========
Eurocrats is a Ruby library that includes a set of tools for dealing with the European VAT. It can be used in Rails as an engine too.

Features
========
Currently it includes these tools:

 * European VAT number validator (through [valvat](https://github.com/yolk/valvat/))
 * VAT calculation
 * IP geo-location (through [Geocoder](https://github.com/alexreisner/geocoder/))
 * User location resolution based on evidences

Current work:

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
Eurocrats adds `eurocrats` method to the regular Rack::Request object. This method instantiates an Eurocrats::Context the first time is invoked and establish the 'ip_location' evidence, which holds the location of the IP address.
Eurocrats depends on the [Geocoder](https://github.com/alexreisner/geocoder) gem, that also includes `location` and `safe_location` in Rack::Request. The latter is used for inferring the location of the IP address.

Examples
========
There are several examples implemented and explained in the `examples` folder.

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

Versioning
----------
Since some APIs are not stable enough, this project is not following the Semantic Versioning strictly. It will adhere to it after version 1.0.0

Contributing
============

Authors
=======
Juan A. Martín Lucas (https://github.com/j-a-m-l)

License
=======
This project is licensed under the MIT license. See [LICENSE]() for details.

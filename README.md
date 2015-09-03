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


Installation
============
TODO

```
gem install eurocrats
```

Use
===
All the tools could be used separately, but eurocrats includes a Context class, that permits an easier and simpler interaction.

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

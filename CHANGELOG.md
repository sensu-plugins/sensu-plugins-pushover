#Change Log
This project adheres to [Semantic Versioning](http://semver.org/).

This CHANGELOG follows the format listed at [Keep A Changelog](http://keepachangelog.com/)

## [Unreleased]
### Added
- Ruby 2.4.1 testing

## [1.0.0] - 2016-07-14
### Changed
- Changed dependency on sensu-plugin from strict (= 1.2.0) to pessimistic (~> 1.2)
- Silenced Object#timeout deprecation warnings under Ruby 2.3 by using Timeout.timeout instead.

### Removed
- Removed Ruby 1.9.3 support; add Ruby 2.3.0 support to test matrix

## [0.0.2] - 2015-07-14
### Changed
- updated sensu-plugin gem to 1.2.0

## 0.0.1 - 2015-07-04
### Added
- initial release

[Unreleased]: https://github.com/sensu-plugins/sensu-plugins-pushover/compare/1.0.0...HEAD
[1.0.0]: https://github.com/sensu-plugins/sensu-plugins-pushover/compare/0.0.2...1.0.0
[0.0.2]: https://github.com/sensu-plugins/sensu-plugins-pushover/compare/0.0.1...0.0.2

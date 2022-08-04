fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios build_test

```sh
[bundle exec] fastlane ios build_test
```

Mandatory for use in circle-ci

Build and Test App

### ios prepare_new_version

```sh
[bundle exec] fastlane ios prepare_new_version
```

Prepare new version on master

### ios beta_testflight

```sh
[bundle exec] fastlane ios beta_testflight
```

Upload to TestFlight

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).

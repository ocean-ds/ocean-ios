fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
## iOS
### ios build_test
```
fastlane ios build_test
```
Mandatory for use in circle-ci

Build and Test App
### ios prepare_new_version
```
fastlane ios prepare_new_version
```
Prepare new version on master
### ios beta_testflight
```
fastlane ios beta_testflight
```
Upload to TestFlight

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).

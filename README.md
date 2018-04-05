# iOS template

[![Swift 4.1](https://img.shields.io/badge/Swift-4.1-orange.svg?style=flat)](https://swift.org)
[![CircleCI](https://img.shields.io/circleci/project/github/Raizlabs/ios-template/master.svg)](https://circleci.com/gh/Raizlabs/ios-template)

A template for new iOS projects at Raizlabs.

Inspired by [thoughtbot]/[ios-template]

[thoughtbot]: https://thoughtbot.com/
[ios-template]: https://github.com/thoughtbot/ios-template

## What's in the template?

 - Configures the project name, company name, lead name, an initial local repo, gitignore, and synx.
 - Option to configure [Hockey][hockey] apps automatically.
 - [Default Fastfile][fastfile] with test, develop, sprint, beta and release lanes and slack notifications.
 - Configuration for [CircleCI][CircleCI] with auto-triggered builds for merges to develop or tags prefixed with sprint, beta or release.
 - [APIClient Stub][apiclient] with functional OAuth implementation and APIEndpoint protocol.
 - [SwiftGen][SwiftGen] configured to generate localized strings and image enums.
 - Default [swiftlint][swiftlint] rules to help enforce code style standards across projects.
 - [Default set of Cocoapods][pods] including:
   - [Anchorage][anchorage] - "A lightweight collection of intuitive operators and utilities that simplify iOS layout code."
   - [BonMot][bonmot] - "Beautiful, easy attributed strings in Swift"
   - [Swiftilities][swiftilities] - Keyboard avoidance guides, lifecycle event code injection, about view, accessibility helpers, color helpers, device size detection, hairline views, logging
   - [KeychainAccess][keychainaccess] - Wrapper for keychain APIs. Used by the Oath implementation to protect credentials
   - [OHHTTPStubs][ohhttpstubs] - Stub API requests with edge case datasets for unit tests or to fake an endpoint while it is in development.

[pods]: PRODUCTNAME/app/Podfile
[anchorage]: https://github.com/Raizlabs/Anchorage
[swiftilities]: https://github.com/Raizlabs/Swiftilities
[bonmot]: httpss://github.com/Raizlabs/BonMot
[keychainaccess]: https://github.com/kishikawakatsumi/KeychainAccess
[ohhttpstubs]: https://github.com/AliSoftware/OHHTTPStubs
[fastfile]: PRODUCTNAME/app/fastlane/Fastfile
[apiclient]: PRODUCTNAME/app/PRODUCTNAME/API 
[CircleCI]: PRODUCTNAME/circle.yml
[swiftlint]: PRODUCTNAME/app/.swiftlint.yml
[hockey]: hooks/post_gen_project.sh
[swiftgen]: https://github.com/SwiftGen/SwiftGen

## Contributing

### Regenerating the Template

⚠️ **Do not** make changes to the `{{ cookiecutter.project_name | replace(' ', '') }}` directory directly! You must first make your changes in the `PRODUCTNAME` folder and then run the `generate_template.sh` script. 

If you place a cookie cutter expansion in a `.pbxproj` file, Xcode will no longer open the project file. To simplify managing the Xcode project, I have a more primitive expansion script in `generate_template.sh` that will replace a smaller set of words with cookiecutter variables. In particular, `PRODUCTNAME` is expanded to `{{ cookiecutter.project_name }}`. Using this simpler form of expansion allows the project in the `PRODUCTNAME` directory to continue to work in Xcode, and lets you manage your template just like any other Xcode project. 

**Every time** you make changes to the PRODUCTNAME folder, you must run `generate_template.sh`:

```bash
$ ./generate_template.sh
```

This script will regenerate the template from scratch, and then verify that it works by running cookiecutter on it, and building/testing the result.

If you are looking to do specific Xcode project modifications, I would recommend using `.xcconfig` files, and placing any expansion in those files. If you are looking to expand variables outside of the project file, you can use cookie cutters `{{ cookiecutter.whatever }}` variables directly.

#### Testing Your Changes

```bash
cookiecutter --no-input --overwrite-if-exists ./
```

After running the `generate_template.sh` script, you can manually run `cookiecutter` and examine the results in the `ProjectName` folder.

## Usage

### Prerequisites

#### Installing Ruby

Install `chruby` to manage your Ruby versions. 

The reason we are using `chruby` is because it is used on CircleCI, and the `.ruby-version` format conflicts with `rvm` (which expects `2.5.1` instead of `ruby-2.5.1`). If you don't have a Ruby version manager installed, you can probably skip all of these steps, but you may run into issues running `fastlane` and `pod` if your system Ruby version and gems do not match the project configuration.

```bash
$ brew install ruby-install chruby
```

Add `chruby` init to your bash profile (usually `~/.profile`).

```bash
$ open ~/.profile 
```

```bash
# Support multiple Ruby versions via chruby
source "/usr/local/opt/chruby/share/chruby/chruby.sh"
source "/usr/local/opt/chruby/share/chruby/auto.sh"
# Optional - automatically/globally switch to chruby's latest Ruby
chruby ruby
```

```bash
$ source ~/.profile
```

Install latest stable Ruby version, which should match the [Ruby version on CircleCI](https://circleci.com/docs/2.0/testing-ios/#custom-ruby-versions) and specified in [`PRODUCTNAME/.ruby-version`](https://github.com/Raizlabs/ios-template/blob/master/PRODUCTNAME/.ruby-version).

```bash
# Install latest stable Ruby
$ ruby-install ruby

# Or install a specific version
$ ruby-install ruby 2.5.1

# Install version matching the project's `.ruby-version` file
$ cd /path/to/ios-template
$ RUBY_VERSION=$(cat PRODUCTNAME/.ruby-version) # e.g. "ruby-2.5.1"
$ ruby-install ruby ${RUBY_VERSION##*-} # e.g. "2.5.1"

# Refresh installed chruby Ruby versions
$ source /usr/local/share/chruby/chruby.sh

# Test that chruby is working
$ chruby # lists available Ruby versions
$ chruby ${RUBY_VERSION} # or `chruby ruby` for latest
$ which ruby # should point to "~/.rubies/${RUBY_VERSION}/bin/ruby"
```

Install the `bundler` gem in the chruby version corresponding to `PRODUCTNAME/.ruby-version`. If you don't install bundler, the template generation will fail.

```bash
# change directory to PRODUCTNAME folder
# chruby should now automatically switch you to the correct Ruby install
$ cd /path/to/ios-template/PRODUCTNAME
# or switch manually
$ chruby $(cat .ruby-version)
$ gem install bundler
```

Now you're ready to generate the new project from the cookiecutter template.

### Installation

1. [Install cookiecutter][cookiecutter] (`brew install cookiecutter` on
   macOS).
1. Run `cookiecutter gh:raizlabs/ios-template`.
1. Answer the questions.
1. Delete anything that is not of interest to your project.

[cookiecutter]: http://cookiecutter.readthedocs.org/en/latest/installation.html

## Configuring the generated project
### Fastlane

### Crashlytics

### Instabug

### OAuth Endpoint

### APIClient 

## Cookie Cutter
Cookie Cutter is a python project for templating files and directories. Cookie cutter will ask a series of questions as defined in `cookiecutter.json` and then run the expansion on the contained files and directory names, and file contents. Anything with `{{ cookiecutter.variable }}` is expanded when the template is expanded. This is a powerful primitive but has some complications with Xcode

## Post processing
Cookie cutter follows a pattern of expand and prune, where the superset of the template is expanded, and then any specific functionality is pruned in a post in shell script `post_gen_project.sh`. You can also run shell scripts to integrate with web services. The included `post_gen_project.sh` is a good example of this, and it will create 2 apps on hockey and configure the `Fastfile`.

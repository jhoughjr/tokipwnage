# tokipwnage

A Toki Pona dictionary and phrase builder for macOS and iOS, built in SwiftUI.

Browse the ~130-word Toki Pona vocabulary, filter by part of speech, favorite
the words you use, hear them spoken aloud, and assemble English → Toki Pona
phrases with the translator.

## Features

- **Dictionary** — every word with its meanings grouped by part of speech, in a
  master/detail split view that adapts to iPhone, iPad, and Mac.
- **Search** — native `.searchable` search across words or meanings, debounced.
- **Filters & favorites** — filter the list by part of speech (wrapping chips)
  or narrow to your starred words; favorites persist across launches.
- **Speech** — speak any word or built phrase with a voice you pick in Settings
  (`AVSpeechSynthesizer`). Speech is gated on a selected voice; with none
  chosen the app stays silent and prompts you to pick one.
- **Translator** — type an English sentence and build the Toki Pona phrase from
  matching words, then speak it.

## Requirements

- Xcode 15+
- macOS 13.0+ / iOS 16.1+

## Build & run

Open `Tokipwnage.xcodeproj` in Xcode and run (⌘R), or from the command line:

```sh
xcodebuild -project Tokipwnage.xcodeproj -scheme Tokipwnage \
  -destination 'platform=macOS,arch=arm64' build
```

Day-to-day builds sign with the automatic **Apple Development** identity, which
runs on the build machine.

## Tests

`TokipwnageTests` covers the vocabulary model (definitions, part-of-speech
ordering/dedup, and the English → Toki Pona word index). Run them from Xcode
(⌘U) — the unit-test host needs a logged-in GUI session, so they don't run
headless over SSH.

## Distribution (macOS)

To run on Macs *other than* the build machine, a build must be signed with the
**Developer ID Application** certificate **and notarized by Apple** — a valid
development signature alone is quarantined by Gatekeeper elsewhere.

`scripts/release.sh` does the whole pipeline: archive → Developer-ID export →
notarize → staple → verify, producing a distributable `build/Tokipwnage.zip`.

One-time credential setup (an app-specific password from
[appleid.apple.com](https://appleid.apple.com) → Sign-In and Security →
App-Specific Passwords):

```sh
xcrun notarytool store-credentials tokipwnage-notary \
  --apple-id jimmyhoughjr@me.com \
  --team-id L9G66SYUL8 \
  --password <app-specific-password>
```

Then:

```sh
./scripts/release.sh
```

The hardened runtime is enabled (required for notarization), and the sandbox
grants a `mach-lookup` exception for `com.apple.audioanalyticsd` so
`AVSpeechSynthesizer` can speak without tripping a sandbox precondition. That
temporary exception is fine for Developer-ID distribution; it would draw
scrutiny only in a Mac App Store submission, where the alternative is to drop
the App Sandbox on the macOS target.

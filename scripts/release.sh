#!/usr/bin/env bash
#
# release.sh — build, Developer-ID sign, notarize, and staple a distributable
# macOS build of Tokipwnage.
#
# The output (build/Tokipwnage.zip) contains a stapled .app that Gatekeeper
# accepts on any Mac — not just the build machine.
#
# One-time setup (stores an app-specific password in the keychain so this runs
# non-interactively). Generate the password at https://appleid.apple.com →
# Sign-In and Security → App-Specific Passwords:
#
#   xcrun notarytool store-credentials tokipwnage-notary \
#     --apple-id jhough39@motech.edu \
#     --team-id L9G66SYUL8 \
#     --password <app-specific-password>
#
# Then just run:  ./scripts/release.sh
#
set -euo pipefail

SCHEME="Tokipwnage"
PROJECT="Tokipwnage.xcodeproj"
NOTARY_PROFILE="${NOTARY_PROFILE:-tokipwnage-notary}"
BUILD_DIR="build"
ARCHIVE="$BUILD_DIR/Tokipwnage.xcarchive"
EXPORT_DIR="$BUILD_DIR/export"
APP="$EXPORT_DIR/Tokipwnage.app"
ZIP="$BUILD_DIR/Tokipwnage.zip"

# Run from the repo root regardless of where the script is invoked.
cd "$(dirname "$0")/.."

echo "==> Cleaning $BUILD_DIR"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

echo "==> Archiving (Release, macOS)"
xcodebuild archive \
  -project "$PROJECT" \
  -scheme "$SCHEME" \
  -configuration Release \
  -destination 'generic/platform=macOS' \
  -archivePath "$ARCHIVE" \
  -allowProvisioningUpdates

echo "==> Exporting with Developer ID"
xcodebuild -exportArchive \
  -archivePath "$ARCHIVE" \
  -exportOptionsPlist scripts/ExportOptions.plist \
  -exportPath "$EXPORT_DIR" \
  -allowProvisioningUpdates

echo "==> Zipping for notarization"
ditto -c -k --keepParent "$APP" "$ZIP"

echo "==> Submitting to Apple notary service (profile: $NOTARY_PROFILE)"
xcrun notarytool submit "$ZIP" --keychain-profile "$NOTARY_PROFILE" --wait

echo "==> Stapling the notarization ticket into the app"
xcrun stapler staple "$APP"
xcrun stapler validate "$APP"

echo "==> Re-zipping the stapled app for distribution"
rm -f "$ZIP"
ditto -c -k --keepParent "$APP" "$ZIP"

echo "==> Verifying signature + Gatekeeper acceptance"
codesign --verify --deep --strict --verbose=2 "$APP"
spctl --assess --type execute --verbose "$APP"

echo ""
echo "==> Done. Distributable: $ZIP"

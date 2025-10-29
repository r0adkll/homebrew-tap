#!/usr/bin/env bash
set -e

usage() {
  cat << EOF
Usage: $0 <VERSION> <MAC_ARM_HASH> <MAC_INTEL_HASH>

Updates the danger-kotlin Dangerfile with the provided Mac ARM and Intel hashes.

Arguments:
  VERSION         The danger-kotlin version (e.g., 2.1.0)
  MAC_ARM_HASH    The SHA256 hash for the Mac ARM danger-kotlin distribution
  MAC_INTEL_HASH  The SHA256 hash for the Mac Intel danger-kotlin distribution
EOF
  exit 1
}

VERSION="$1"
MAC_ARM_HASH="$2"
MAC_INTEL_HASH="$3"

# Validate inputs
if [[ -z "$VERSION" || -z "$MAC_ARM_HASH" || -z "$MAC_INTEL_HASH" ]]; then
  usage
fi

# Check if git has any uncommitted changes
if [[ -n $(git status --porcelain) ]]; then
  echo "Error: You have uncommitted changes in your git repository. Please commit or stash them before running this script."
  exit 1
fi

# Replace the "version" parameter with "$VERSION" in danger-kotlin.rb
# Then replace the "sha256" parameters for Mac ARM and Intel with the provided hashes
sed -i '' \
    -e '/version /{s/"[^"]*"/"'"$VERSION"'"/;}' \
    -e '/if Hardware::CPU\.arm?/,/end/{s/sha256 "[^"]*"/sha256 "'"$MAC_ARM_HASH"'"/;}' \
    -e '/if Hardware::CPU\.intel?/,/end/{s/sha256 "[^"]*"/sha256 "'"$MAC_INTEL_HASH"'"/;}' \
    danger-kotlin.rb

# Stage and commit the changes with a message "Updating danger-kotlin to $VERSION"
git add danger-kotlin.rb
git commit -m "Updating danger-kotlin to $VERSION"
git push origin main
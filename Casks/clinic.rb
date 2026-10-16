# Written by scripts/publish in r0adkll/clinic for each release; edit it there.
cask "clinic" do
  version "0.5.0"
  sha256 "3aea1380ed4853fdf13edc25f9a60b5a0817015402e48c3f2bf464420c29bc75"

  url "https://github.com/r0adkll/clinic/releases/download/#{version}/Clinic-#{version}.zip"
  name "Clinic"
  desc "Session manager for Claude Code"
  homepage "https://github.com/r0adkll/clinic"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "Clinic.app"

  uninstall launchctl: "com.r0adkll.clinic.wake",
            quit:      "com.r0adkll.clinic"

  zap trash: [
    "~/Library/Application Support/Clinic",
    "~/Library/Preferences/com.r0adkll.clinic.plist",
  ]

  caveats "Clinic runs the claude CLI, which must be on your PATH."
end

# Written by scripts/publish in r0adkll/clinic for each release; edit it there.
cask "clinic" do
  version "0.7.0"
  sha256 "5f80667f4f54cd88d6dfa932e9e41e7e79412a67ef5f9f3e72c9037e08b870d7"

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

# Written by scripts/publish in r0adkll/clinic for each release; edit it there.
cask "clinic" do
  version "0.3.1"
  sha256 "2d260818e40e26dc75087a74dafbc013d5757606aa1bf35bba14dacfcf5ed8b6"

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

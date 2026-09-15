# Written by scripts/publish in r0adkll/clinic for each release; edit it there.
cask "clinic" do
  version "0.1.0"
  sha256 "5664cc09465b3d6381fa68158a1510b498ad50e8a77d5711c2593319edb1bf7b"

  url "https://github.com/r0adkll/clinic/releases/download/#{version}/Clinic-#{version}.zip"
  name "Clinic"
  desc "Claude Code session manager on libghostty"
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

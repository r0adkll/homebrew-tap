# Written by scripts/publish-cask in r0adkll/Campfire for each release; edit it there.
cask "campfire" do
  arch arm: "aarch64", intel: "amd64"

  version "1.2.1"
  sha256 arm:   "e54354a95366433b873b0b9c4c62ed1ce597f91502b346f7b30ee3b57ebe6747",
         intel: "97e946a0bed2742863bc01a697a0abdfaeede02bbbb54c5e3e31c1728005f394"

  url "https://github.com/r0adkll/Campfire/releases/download/#{version}/campfire-#{version}-mac-#{arch}.zip"
  name "Campfire"
  desc "Audiobook player for Audiobookshelf servers"
  homepage "https://github.com/r0adkll/Campfire"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Updates itself through Sparkle, so brew leaves the installed copy alone unless asked greedily.
  auto_updates true
  depends_on macos: :sequoia

  app "Campfire.app"

  uninstall quit: "app.campfire"

  zap trash: [
    "~/.config/Campfire",
    "~/Library/Caches/app.campfire",
    "~/Library/Preferences/app.campfire.plist",
  ]
end

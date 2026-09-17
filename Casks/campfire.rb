# Written by scripts/publish-cask in r0adkll/Campfire for each release; edit it there.
cask "campfire" do
  arch arm: "aarch64", intel: "amd64"

  version "1.2.0"
  sha256 arm:   "ce0a2c6ab432e956ef26a4d72c450c7cd315f4e1db0d038758ee99cf480c884d",
         intel: "bf37a765573771a9b299196fe49d55038e962e4ea8ac38c8934ad55387f05855"

  url "https://github.com/r0adkll/Campfire/releases/download/#{version}/campfire-#{version}-mac-#{arch}.zip",
      verified: "github.com/r0adkll/Campfire/"
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

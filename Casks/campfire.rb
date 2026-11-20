# Written by scripts/publish-cask in r0adkll/Campfire for each release; edit it there.
cask "campfire" do
  arch arm: "aarch64", intel: "amd64"

  version "1.3.0"
  sha256 arm:   "7b12bad1c1efc86bfb38842506a8985b4d8da697cb2d7e193cda54665993ae62",
         intel: "fe70fd43c228a4af6116772668a549f554d8f9ac1618bd9d90291ebcb0644446"

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

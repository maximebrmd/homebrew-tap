cask "kitten-island" do
  version "0.1.2"
  sha256 "7185a9d569767aa5507ff144a0db35aa4b0a38c25cc9cedf6ccaed9b4c2d4c99"

  url "https://github.com/maximebrmd/homebrew-tap/releases/download/kitten-island-#{version}/KittenIsland-#{version}.dmg",
      verified: "github.com/maximebrmd/homebrew-tap/"
  name "KittenIsland"
  desc "Notch control center for AI coding agents"
  homepage "https://github.com/maximebrmd/homebrew-tap"

  livecheck do
    url :url
    regex(/^kitten-island[._-]v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  depends_on macos: :sonoma

  app "KittenIsland.app"

  uninstall quit: "com.maximebrmd.KittenIsland"

  zap trash: [
    "~/.kitten-island",
    "~/Library/Caches/com.maximebrmd.KittenIsland",
    "~/Library/HTTPStorages/com.maximebrmd.KittenIsland",
    "~/Library/Preferences/com.maximebrmd.KittenIsland.plist",
    "~/Library/Saved Application State/com.maximebrmd.KittenIsland.savedState",
  ]

  caveats <<~EOS
    KittenIsland is ad-hoc signed, not notarized by Apple, so Gatekeeper will refuse
    to open it. Clear the quarantine flag once, now:

      xattr -dr com.apple.quarantine /Applications/KittenIsland.app

    Homebrew quarantines every cask and no longer offers a flag to opt out, so this
    step is required after each install or upgrade.

    KittenIsland is a menu-bar app — it has no Dock icon. Look for the pixel cat in
    your menu bar, and for the panel in your notch.

    It needs Accessibility and Automation permission to locate your terminal and send
    keystrokes to it. macOS will prompt on first use.

    Before uninstalling, open Settings -> Integrations and remove the agent hooks.
    KittenIsland installs observer hooks into ~/.claude, ~/.codex, ~/.pi and friends;
    `brew uninstall` cannot reach into those files, and `zap` deliberately does not
    touch your agent configs.
  EOS
end

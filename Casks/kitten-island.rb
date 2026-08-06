cask "kitten-island" do
  version "0.1.0"
  sha256 "ee045fae73fc349e60e3e73a946a0932a479f977491c2884c40e83b2728f24cc"

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

  depends_on macos: ">= :sonoma"

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
    KittenIsland is ad-hoc signed, not notarized by Apple. Gatekeeper will refuse to
    open it after a normal install. Install it without the quarantine flag:

      brew install --cask --no-quarantine maximebrmd/tap/kitten-island

    If you already installed it the normal way, clear the flag once:

      xattr -dr com.apple.quarantine /Applications/KittenIsland.app

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

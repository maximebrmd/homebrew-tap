cask "kitten-island" do
  version "0.2.0"
  sha256 "b1f4645183e0b76876ad37473e0ecfff4944f300ee4737e9e3b1599886435e0f"

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

    Jumping to a terminal pane needs no permission for WezTerm or tmux. iTerm2 and
    Terminal.app ask for Automation the first time; macOS prompts you. Accessibility
    is never required — keystrokes go to one pane through that terminal's own
    command-line interface, never as system-wide input.

    To follow your Claude Code sessions, KittenIsland adds marked, backed-up entries
    to ~/.claude/settings.json: lifecycle observers, plus a statusLine for the 5h/7d
    usage percentages. No other agent's config is touched, and the extra agents under
    Settings -> Integrations stay off until you switch them on.

    `brew uninstall` cannot reach into that file and `zap` deliberately leaves agent
    configs alone, so remove those entries before uninstalling: turn off
    Settings -> Usage, then delete any remaining hook entry whose command contains
    `kitten-hook`.
  EOS
end

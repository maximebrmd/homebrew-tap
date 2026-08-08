cask "kitten-island" do
  version "0.3.0"
  sha256 "86d46d36e32419307213e4145f8099276a7e62a41fb662b25eee769b8eab3547"

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

    KittenIsland writes nothing into any agent's configuration until you ask it to.
    Claude Code, Codex and Pi are detected by reading the session files they already
    write. Settings -> Integrations carries a switch that merges six lifecycle
    observer entries into ~/.claude/settings.json so the notch notices a session
    sooner; it starts off, and the usage status line under Settings -> Usage is gated
    by it. Every switch names the exact file it writes, the file is backed up and
    validated before it is changed, and hooks belonging to other tools are left as
    they were.

    Upgrading from an earlier build? Those entries used to be added on every launch
    without asking. This build takes them back out on first launch and tells you so.

    Turning a switch off is the removal, and it sticks. To be rid of all of it at
    once, use About -> Remove Everything KittenIsland Installed, which also deletes
    ~/.kitten-island and the kitten-hook helper your agents run, then quits. Do that
    BEFORE you delete the app: the helper lives outside the app bundle, so moving
    KittenIsland to the Trash leaves it running. `brew uninstall` cannot reach into
    an agent's config, and `zap` deliberately leaves them alone.
  EOS
end

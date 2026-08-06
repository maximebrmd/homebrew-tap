# maximebrmd/homebrew-tap

Homebrew tap for my apps.

```sh
brew tap maximebrmd/tap
```

## 🐱 KittenIsland

Turn your MacBook notch into a control center for your AI coding agents. A Dynamic-Island-style
panel that keeps every agent session in view, tells you the moment one needs you, jumps you to the
exact terminal, and lets you approve, deny, or answer — without leaving what you're doing.

Native Swift, no Electron, near-zero idle CPU.

```sh
brew install --cask --no-quarantine maximebrmd/tap/kitten-island
```

> `--no-quarantine` is required. KittenIsland is ad-hoc signed rather than notarized by Apple, so
> Gatekeeper refuses to open it after a normal install. If you already installed it without the
> flag, clear it once with
> `xattr -dr com.apple.quarantine /Applications/KittenIsland.app`.

KittenIsland is a **menu-bar app** — no Dock icon. Look for the pixel cat in your menu bar.

Requires macOS 14 (Sonoma) or later. Universal — Apple silicon and Intel.

### Uninstalling

Open **Settings → Integrations** and remove the agent hooks *before* uninstalling. KittenIsland
installs observer hooks into `~/.claude`, `~/.codex`, `~/.pi` and friends, and Homebrew cannot
reach into those files.

```sh
brew uninstall --cask kitten-island   # removes the app
brew uninstall --zap --cask kitten-island   # also removes ~/.kitten-island and preferences
```

`zap` deliberately leaves your agent configs alone.

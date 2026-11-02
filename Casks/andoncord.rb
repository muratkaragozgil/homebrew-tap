cask "andoncord" do
  version "0.3.0"
  sha256 "b63b84af50626226353c7944a1f8fcd4eb38454a2780745f30c11583e9b400a5"

  url "https://github.com/muratkaragozgil/andoncord/releases/download/v#{version}/AndonCord.dmg"
  name "AndonCord"
  desc "Notch dashboard for Claude Code sessions, approvals and usage limits"
  homepage "https://github.com/muratkaragozgil/andoncord"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "AndonCord.app"

  uninstall quit: "app.andoncord.mac"

  # ~/.andoncord/bin is left alone on purpose: ~/.claude/settings.json points
  # its hooks there, and the launchers exit 0 once the app is gone. Deleting
  # them would turn every Claude Code hook into a "command not found".
  zap trash: [
    "~/.andoncord/quota-calibration.json",
    "~/.andoncord/rate-limits.json",
    "~/.andoncord/usage-history.jsonl",
    "~/.andoncord/usage-index.json",
    "~/Library/Preferences/app.andoncord.mac.plist",
  ]

  caveats <<~EOS
    To take AndonCord's hooks out of ~/.claude/settings.json, use
    AndonCord → Settings → Remove before uninstalling. Left in place they
    are harmless: they exit immediately once the app is gone.
  EOS
end

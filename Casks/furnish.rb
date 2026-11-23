cask "furnish" do
  version "0.1.0"
  sha256 "1dc21f59264265b52ecc5bbe0e7c2f5f3b0809d661dfcbfcb0425a755a963aeb"

  url "https://github.com/furnish-self-service/furnish/releases/download/v#{version}/furnish_#{version}_arm64.dmg"
  name "furnish"
  desc "Self-service app catalog for an organization's computers"
  homepage "https://furnish-self-service.github.io/"

  depends_on arch: :arm64
  depends_on :macos

  app "furnish.app"
  binary "#{appdir}/furnish.app/Contents/MacOS/furnish"

  uninstall quit: "io.github.furnish-self-service.furnish"

  # The sign-in item (a LaunchAgent) only goes with zap: uninstall steps also run on upgrade.
  zap launchctl: "io.github.furnish-self-service.furnish.autostart",
      trash:     [
        "~/Library/Application Support/furnish",
        "~/Library/Application Support/io.github.furnish-self-service.furnish",
        "~/Library/Caches/io.github.furnish-self-service.furnish",
        "~/Library/HTTPStorages/io.github.furnish-self-service.furnish",
        "~/Library/Preferences/io.github.furnish-self-service.furnish.plist",
        "~/Library/Saved Application State/io.github.furnish-self-service.furnish.savedState",
        "~/Library/WebKit/io.github.furnish-self-service.furnish",
      ]
end

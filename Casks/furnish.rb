cask "furnish" do
  version "0.1.0-alpha.223"
  sha256 "206e1fc0083c8aa7307848efc105c2b275f5d7a2923810299ca9d9574876fa91"

  url "https://github.com/furnish-self-service/furnish/releases/download/v#{version}/furnish_#{version}_arm64.dmg"
  name "furnish"
  desc "Self-service app catalog for an organization's computers"
  homepage "https://furnish-self-service.github.io/"

  # Alpha builds are GitHub pre-releases, which the default strategy skips.
  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+-alpha\.\d+)$/i)
    strategy :github_releases do |json, regex|
      json.map { |release| release["tag_name"]&.[](regex, 1) }
    end
  end

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

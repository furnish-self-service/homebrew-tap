cask "furnish" do
  version "0.1.0-alpha.276"
  sha256 "7e37a5d84f6cb53de2e1b82597d9e7d6db4510a7b429b585c1b51a3bf23caa60"

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

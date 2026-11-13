cask "scalebar" do
  version "1.1.2"
  sha256 "44024ee2443dbb7bf9f6cb1950f1ed1ca1a91735dd17d953e03ba175270159cb"

  url "https://github.com/javedh-dev/ScaleBar/releases/download/v#{version}/ScaleBar-#{version}.zip"
  name "ScaleBar"
  desc "Sharp HiDPI scaling, brightness and volume for external monitors"
  homepage "https://github.com/javedh-dev/ScaleBar"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "ScaleBar.app"

  # ScaleBar isn't notarized (that needs a paid Apple developer account), so without this macOS
  # would block the first launch. Only this app's quarantine flag is removed.
  postflight_steps do
    run "/usr/bin/xattr", args:           ["-dr", "com.apple.quarantine", "{{appdir}}/ScaleBar.app"],
                          writable_paths: ["{{appdir}}/ScaleBar.app"]
  end

  uninstall quit: "local.scalebar"

  zap trash: "~/Library/Preferences/local.scalebar.plist"
end

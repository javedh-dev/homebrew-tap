cask "scalebar" do
  version "1.1.3"
  sha256 "0304f4a2d131f96e3e36874eda942ff40831f4f1dbd1369eed47c12ad46e8f9b"

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

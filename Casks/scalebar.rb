cask "scalebar" do
  version "1.3.0"
  sha256 "ba96a0dd1b0967b60b8d5de1906791425b5afbfe86e3b857654f56a052a00556"

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

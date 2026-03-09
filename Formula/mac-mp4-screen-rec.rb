class MacMp4ScreenRec < Formula
  desc "Automatically convert macOS screen recordings from MOV to MP4"
  homepage "https://github.com/arch1904/MacMp4ScreenRec"
  url "https://github.com/arch1904/MacMp4ScreenRec/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "064a3dee68b04d9a37708583699a650780d6cadf427b4ef64e4be0a5d10536b2"
  license "MIT"
  version "1.0.0"

  depends_on "ffmpeg"
  depends_on :macos

  def install
    bin.install "mac-mp4-screen-rec"
  end

  def post_install
    ohai "Run 'mac-mp4-screen-rec start' to start the background service"
    ohai "Run 'mac-mp4-screen-rec add ~/Desktop' to watch a directory"
  end

  def caveats
    <<~EOS
      To start converting screen recordings automatically:
        mac-mp4-screen-rec start

      By default, ~/Desktop is watched. Add more directories with:
        mac-mp4-screen-rec add <path>

      The service starts automatically on login once started.
    EOS
  end

  test do
    assert_match "mac-mp4-screen-rec v#{version}", shell_output("#{bin}/mac-mp4-screen-rec version")
  end
end

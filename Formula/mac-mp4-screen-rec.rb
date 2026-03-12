class MacMp4ScreenRec < Formula
  desc "Automatically convert macOS screen recordings and other video files"
  homepage "https://github.com/arch1904/MacMp4ScreenRec"
  url "https://github.com/arch1904/MacMp4ScreenRec/archive/refs/tags/v1.2.1.tar.gz"
  sha256 "19579fea06c20819f232a8aa256dda9b7a0e669952889751f9a1a6f2faed973c"
  license "MIT"
  version "1.2.1"
  head "https://github.com/arch1904/MacMp4ScreenRec.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)\.tar\.gz$/i)
  end

  depends_on "ffmpeg"
  depends_on :macos

  def install
    bin.install "mac-mp4-screen-rec"
    man1.install "docs/man/mac-mp4-screen-rec.1" if File.exist?("docs/man/mac-mp4-screen-rec.1")
  end

  def post_install
    ohai "Run 'mac-mp4-screen-rec start' to start the background service"
    ohai "Run 'mac-mp4-screen-rec add ~/Desktop' to watch a directory"
  end

  def caveats
    if build.head?
      <<~EOS
        You installed the HEAD build from main.

        To start converting files automatically:
          mac-mp4-screen-rec start

        Defaults:
          watch path:       ~/Desktop
          selection mode:   recordings-only
          input extensions: mov
          output extension: mp4
          codecs:           copy/copy

        You can inspect or change the full config with:
          mac-mp4-screen-rec config
          mac-mp4-screen-rec config --all-files --input-extensions mov,mkv
          mac-mp4-screen-rec config --video-codec libx264 --audio-codec aac
          mac-mp4-screen-rec config --map-video-codec hevc=libx264
          mac-mp4-screen-rec config --map-audio-codec pcm_s16le=aac
          mac-mp4-screen-rec config --keep-original-days 7
      EOS
    else
      <<~EOS
        To start converting files automatically:
          mac-mp4-screen-rec start

        Defaults:
          watch path:       ~/Desktop
          selection mode:   recordings-only
          input extensions: mov
          output extension: mp4
          codecs:           copy/copy

        You can inspect or change the full config with:
          mac-mp4-screen-rec config
          mac-mp4-screen-rec config --all-files --input-extensions mov,mkv
          mac-mp4-screen-rec config --video-codec libx264 --audio-codec aac
          mac-mp4-screen-rec config --map-video-codec hevc=libx264
          mac-mp4-screen-rec config --map-audio-codec pcm_s16le=aac
          mac-mp4-screen-rec config --keep-original-days 7
      EOS
    end
  end

  test do
    assert_match "mac-mp4-screen-rec v", shell_output("#{bin}/mac-mp4-screen-rec version")
  end
end

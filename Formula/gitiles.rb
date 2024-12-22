class Gitiles < Formula
  desc "Simple browser for Git repositories"
  homepage "https://github.com/hyxf/gitiles"
  url "https://github.com/hyxf/gitiles/releases/download/v1.5.0/gitiles-1.5.0.jar"
  sha256 "97de59db4a8a12c19ce291811f98d159c0de1bb8ec4930170614a477431d4f44"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "openjdk@17"

  def install
    libexec.install "gitiles-#{version}.jar"
    bin.write_jar_script libexec/"gitiles-#{version}.jar", "gitiles"
  end

  def caveats
    <<~EOS
      Note: When using launchctl the port will be 8089.
    EOS
  end

  service do
    run [opt_bin/"gitiles", "--dir", "~/Mirror/github", "--ip", "127.0.0.1", "--port", "8089"]
    keep_alive true
    log_path var/"log/gitiles/output.log"
    error_log_path var/"log/gitiles/error.log"
  end

  test do
    system "#{bin}/gitiles", "--version"
  end
end

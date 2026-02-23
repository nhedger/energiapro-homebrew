class Energiapro < Formula
  desc "Command-line interface for the EnergiaPro API"
  homepage "https://github.com/nhedger/energiapro"
  version "0.2.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nhedger/energiapro/releases/download/cli-v#{version}/energiapro-aarch64-apple-darwin"
      sha256 "3289c8641c0238d7f841f4884e71f9f9885170f1965c34e5da4df33b1a390626"
    else
      url "https://github.com/nhedger/energiapro/releases/download/cli-v#{version}/energiapro-x86_64-apple-darwin"
      sha256 "08abf0270c68998b17ff28ac764fe2b95cdf5b3d78137663280eb68543ab5403"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nhedger/energiapro/releases/download/cli-v#{version}/energiapro-x86_64-unknown-linux-gnu"
      sha256 "a0050ab1b111c1424ab32221b819f73f8c44e4bada442e5bbfc84eab5bf8fbb8"
    elsif Hardware::CPU.arm?
      url "https://github.com/nhedger/energiapro/releases/download/cli-v#{version}/energiapro-aarch64-unknown-linux-gnu"
      sha256 "8eb848fa3c16b8e325ac7b15fcb6cbb71b364042269f2181d1b0aed0ab0cf8a2"
    else
      odie "Unsupported Linux architecture: #{Hardware::CPU.arch}"
    end
  end

  def install
    binary = if OS.mac? && Hardware::CPU.arm?
      "energiapro-aarch64-apple-darwin"
    elsif OS.mac? && Hardware::CPU.intel?
      "energiapro-x86_64-apple-darwin"
    elsif OS.linux? && Hardware::CPU.intel?
      "energiapro-x86_64-unknown-linux-gnu"
    elsif OS.linux? && Hardware::CPU.arm?
      "energiapro-aarch64-unknown-linux-gnu"
    else
      odie "Unsupported platform"
    end

    bin.install binary => "energiapro"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/energiapro --version")
  end
end

class Energiapro < Formula
  desc "Command-line interface for the EnergiaPro API"
  homepage "https://github.com/nhedger/energiapro"
  version "0.1.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nhedger/energiapro/releases/download/cli-v#{version}/energiapro-aarch64-apple-darwin"
      sha256 "30fe01f8d122ffa1b5649c82f341cb0463a1d6f140c1d561cfc35b8118b14124"
    else
      url "https://github.com/nhedger/energiapro/releases/download/cli-v#{version}/energiapro-x86_64-apple-darwin"
      sha256 "13ac897eb08f7a369cb7af70babd3f0d6fcfeea2dc6ad548e6659904472c0d87"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nhedger/energiapro/releases/download/cli-v#{version}/energiapro-x86_64-unknown-linux-gnu"
      sha256 "ec73cdf95bc27dadde0f4b9d10c99a5b1b69f0fa882eff9f4bfc77ae03d976e0"
    elsif Hardware::CPU.arm?
      url "https://github.com/nhedger/energiapro/releases/download/cli-v#{version}/energiapro-aarch64-unknown-linux-gnu"
      sha256 "db59f08cfb206a8dc7a9bc6eeef1c48cf457159423f495a87898dde1e2116fa3"
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

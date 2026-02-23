class Energiapro < Formula
  desc "Command-line interface for the EnergiaPro API"
  homepage "https://github.com/nhedger/energiapro"
  version "0.1.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nhedger/energiapro/releases/download/cli-v#{version}/energiapro-aarch64-apple-darwin"
      sha256 "31701de012200d4e6a0e92fbc64a72ec3b27e59c29e840142d4d2dc97217d632"
    else
      url "https://github.com/nhedger/energiapro/releases/download/cli-v#{version}/energiapro-x86_64-apple-darwin"
      sha256 "7f2f464ca1b157f3d04387feb1eb1ff50d30b5d8af79dae10fdddacbc5abb200"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nhedger/energiapro/releases/download/cli-v#{version}/energiapro-x86_64-unknown-linux-gnu"
      sha256 "ec53578dcf3a0d1a1fb25b183a878bf7b16c337196ac993435d1b8301446a7ff"
    elsif Hardware::CPU.arm?
      url "https://github.com/nhedger/energiapro/releases/download/cli-v#{version}/energiapro-aarch64-unknown-linux-gnu"
      sha256 "fe4967005bc07f27ff6e419c285ff53d67f490872382e430076cbf455aac4870"
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

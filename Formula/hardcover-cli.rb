class HardcoverCli < Formula
  desc "Command-line client for Hardcover.app, built for agents first"
  homepage "https://github.com/r0adkll/hardcover-cli"
  version "0.4.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/r0adkll/hardcover-cli/releases/download/v0.4.1/hardcover-cli-aarch64-apple-darwin.tar.xz"
      sha256 "18617137b44be39a79448e61e5f37ac462ece3234c6dc9e50a3e3a43821e968e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/r0adkll/hardcover-cli/releases/download/v0.4.1/hardcover-cli-x86_64-apple-darwin.tar.xz"
      sha256 "13b839487556f1883ca09f4610de6a0eb33687a1ab558631fde4c1e2f2bac0ec"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/r0adkll/hardcover-cli/releases/download/v0.4.1/hardcover-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "585248b9b962b357e7c06f5912798f5f16deaacf57a2b7f61deacaf40bac2af7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/r0adkll/hardcover-cli/releases/download/v0.4.1/hardcover-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2c2196c6faca9444caaf0fd6ad9dfb9cad826d8812d298809d9913b41b39213a"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "hardcover"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "hardcover"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "hardcover"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "hardcover"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

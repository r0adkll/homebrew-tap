class HardcoverCli < Formula
  desc "Command-line client for Hardcover.app, built for agents first"
  homepage "https://github.com/r0adkll/hardcover-cli"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/r0adkll/hardcover-cli/releases/download/v0.6.0/hardcover-cli-aarch64-apple-darwin.tar.xz"
      sha256 "a82f60abb120444ee89cfc10f715861aa7d9a1d905a0c3c3c45d28c6a329fc4a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/r0adkll/hardcover-cli/releases/download/v0.6.0/hardcover-cli-x86_64-apple-darwin.tar.xz"
      sha256 "40c22f00f54885c71ccf7ca3eaa85a0751fbff5d9991232bea3bae5180427ed3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/r0adkll/hardcover-cli/releases/download/v0.6.0/hardcover-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "879f17999b472c2e873d2d31ff1fec58eebf265868f7ae21f805d40b172f991a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/r0adkll/hardcover-cli/releases/download/v0.6.0/hardcover-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b0be69f8f12fbf64b1cde8740eebd9f53acb0754c265666aa02e39c8e13ffb37"
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

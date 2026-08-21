class HardcoverCli < Formula
  desc "Command-line client for Hardcover.app, built for agents first"
  homepage "https://github.com/r0adkll/hardcover-cli"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/r0adkll/hardcover-cli/releases/download/v0.5.0/hardcover-cli-aarch64-apple-darwin.tar.xz"
      sha256 "66e63481b9ff3151af0c12802b651f56fac1bc548564157dbd7fba27fc6de21b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/r0adkll/hardcover-cli/releases/download/v0.5.0/hardcover-cli-x86_64-apple-darwin.tar.xz"
      sha256 "f2524020b7345fa1b2a66ef4860337ad574c2146d2a32fd56033fe5c33a9294f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/r0adkll/hardcover-cli/releases/download/v0.5.0/hardcover-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "92c839cc9ddaccfc7c163d003f5b29ae7b203915f312482b6856b01edf50f473"
    end
    if Hardware::CPU.intel?
      url "https://github.com/r0adkll/hardcover-cli/releases/download/v0.5.0/hardcover-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cf7d98e8b33f1b40629c4bc54c3bcefbec926b83c7bdc035c6624a5bf626cb6f"
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

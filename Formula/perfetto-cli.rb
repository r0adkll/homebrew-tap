class PerfettoCli < Formula
  desc "A Rust TUI for managing Android Perfetto trace sessions."
  homepage "https://github.com/r0adkll/perfetto-cli"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/r0adkll/perfetto-cli/releases/download/v0.6.0/perfetto-cli-aarch64-apple-darwin.tar.xz"
      sha256 "05a23190558594df35f176cd93b0e53e3fb65a1bd268f5728e0234a012d6e9f3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/r0adkll/perfetto-cli/releases/download/v0.6.0/perfetto-cli-x86_64-apple-darwin.tar.xz"
      sha256 "ff11304713376bdc50a0ee794888e87dca5a5f4f0e93371a1069fd2c359e37f7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/r0adkll/perfetto-cli/releases/download/v0.6.0/perfetto-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "addc7c8820e208add36850bc2493420f55adf6f0241245fe7d47f6567f51f5ba"
    end
    if Hardware::CPU.intel?
      url "https://github.com/r0adkll/perfetto-cli/releases/download/v0.6.0/perfetto-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "71e888b088c0a561a70173d80f83ed8e6e835a1eb61639d4e8b5a874ffbfdfcc"
    end
  end
  license "MIT"

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
      bin.install "perfetto-cli"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "perfetto-cli"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "perfetto-cli"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "perfetto-cli"
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

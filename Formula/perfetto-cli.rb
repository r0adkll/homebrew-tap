class PerfettoCli < Formula
  desc "A Rust TUI for managing Android Perfetto trace sessions."
  homepage "https://github.com/r0adkll/perfetto-cli"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/r0adkll/perfetto-cli/releases/download/v0.3.1/perfetto-cli-aarch64-apple-darwin.tar.xz"
      sha256 "7ed28e76f63127204fdd0cf675c8e6f3a8d48b8251f21a7048cb4613abca349d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/r0adkll/perfetto-cli/releases/download/v0.3.1/perfetto-cli-x86_64-apple-darwin.tar.xz"
      sha256 "b944d6ec2199394e330273c10c6b4250d3ae348495699f95ae8875c76c6216f9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/r0adkll/perfetto-cli/releases/download/v0.3.1/perfetto-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a6af076758269ddd7edf02cf5a0b006119b97e15c921bca946b5888baceccb7c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/r0adkll/perfetto-cli/releases/download/v0.3.1/perfetto-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d393d5b3fbe7c6a4dd868b9fe20474f1c68ebbe452736c502cdd03a13a7fd0b0"
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
    bin.install "perfetto-cli" if OS.mac? && Hardware::CPU.arm?
    bin.install "perfetto-cli" if OS.mac? && Hardware::CPU.intel?
    bin.install "perfetto-cli" if OS.linux? && Hardware::CPU.arm?
    bin.install "perfetto-cli" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

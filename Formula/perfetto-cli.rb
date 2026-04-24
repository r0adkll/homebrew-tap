class PerfettoCli < Formula
  desc "A Rust TUI for managing Android Perfetto trace sessions."
  homepage "https://github.com/r0adkll/perfetto-cli"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/r0adkll/perfetto-cli/releases/download/v0.5.1/perfetto-cli-aarch64-apple-darwin.tar.xz"
      sha256 "bb440fa68c097c5286890c29f81cdd16f5066c32d4aaa58a2ad432ed273d135e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/r0adkll/perfetto-cli/releases/download/v0.5.1/perfetto-cli-x86_64-apple-darwin.tar.xz"
      sha256 "3f050f48748020605158abd1c8d31e99b269d2f685d8dbb21e7a8e791b5eb9b8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/r0adkll/perfetto-cli/releases/download/v0.5.1/perfetto-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "acbbe14cc9b47276d09d6d40789aba9a02c5466ddaff902cc34aa40f6b522de0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/r0adkll/perfetto-cli/releases/download/v0.5.1/perfetto-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "64275f8befb82866feb159c8b517217ae2c0ba0789926ea33156421c89bb8832"
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

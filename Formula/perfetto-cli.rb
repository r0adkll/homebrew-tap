class PerfettoCli < Formula
  desc "A Rust TUI for managing Android Perfetto trace sessions."
  homepage "https://github.com/r0adkll/perfetto-cli"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/r0adkll/perfetto-cli/releases/download/v0.4.0/perfetto-cli-aarch64-apple-darwin.tar.xz"
      sha256 "3c410139529975861a37ab87e9dedb8dc147a0db94936afd2b1a266b5428d87b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/r0adkll/perfetto-cli/releases/download/v0.4.0/perfetto-cli-x86_64-apple-darwin.tar.xz"
      sha256 "ec92fde78b37e7a4970d3d68c60f6eda6ab2537bec0a926bd23f0b2ad29f0e54"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/r0adkll/perfetto-cli/releases/download/v0.4.0/perfetto-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ebab6ff122aa23fac02ba4d43bd90072d05bd806b80564686f2cdba51f3770db"
    end
    if Hardware::CPU.intel?
      url "https://github.com/r0adkll/perfetto-cli/releases/download/v0.4.0/perfetto-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c0fbdef302c62806b2917212b4fc4e622d52e941a87ad9f8c4cb9869bb8e1657"
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

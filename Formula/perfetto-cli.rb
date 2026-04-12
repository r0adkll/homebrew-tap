class PerfettoCli < Formula
  desc "A Rust TUI for managing Android Perfetto trace sessions."
  homepage "https://github.com/r0adkll/perfetto-cli"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/r0adkll/perfetto-cli/releases/download/v0.2.0/perfetto-cli-aarch64-apple-darwin.tar.xz"
      sha256 "2d48ae618380604620fc2ff5b230a1b41ab3096167bff0dee4a38faaacb0eb91"
    end
    if Hardware::CPU.intel?
      url "https://github.com/r0adkll/perfetto-cli/releases/download/v0.2.0/perfetto-cli-x86_64-apple-darwin.tar.xz"
      sha256 "92dafd6b0b12d3034c7e6306a8e820530150cd8c7973283167ad3ff4fa59d683"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/r0adkll/perfetto-cli/releases/download/v0.2.0/perfetto-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9acb9813b60657c23fef7ddc6f3475f6fcc3ab0a0781ea2f397495629c2137a4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/r0adkll/perfetto-cli/releases/download/v0.2.0/perfetto-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f4471fcf18e51428be2ec980461ab5d007f203a67d8ce937e26cd4ff26ab35ca"
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

class PerfettoCli < Formula
  desc "A Rust TUI for managing Android Perfetto trace sessions."
  homepage "https://github.com/r0adkll/perfetto-cli"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/r0adkll/perfetto-cli/releases/download/v0.5.0/perfetto-cli-aarch64-apple-darwin.tar.xz"
      sha256 "26fcabbe6058a7305fe78ee4bda915a828af6c793c765de9a03fc5b801528a23"
    end
    if Hardware::CPU.intel?
      url "https://github.com/r0adkll/perfetto-cli/releases/download/v0.5.0/perfetto-cli-x86_64-apple-darwin.tar.xz"
      sha256 "ff19894ec53aba0c1925b08a4b1a10abe92ebc1582e02611f657114a7280aa2e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/r0adkll/perfetto-cli/releases/download/v0.5.0/perfetto-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e7451fa171901b6932ff20bba27c103f8da9dcb8f4581753f54307656f2b4f4b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/r0adkll/perfetto-cli/releases/download/v0.5.0/perfetto-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "273298b0f5c5fcf8569a44cf9479fef5b3581236150d2e386db4f2cec9d15bad"
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

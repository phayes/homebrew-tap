class ArdftsrcRs < Formula
  desc "Command-line wav and flac sample-rate converter powered by ardftsrc."
  homepage "https://github.com/phayes/ardftsrc-rs"
  version "0.4.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/phayes/ardftsrc-rs/releases/download/v0.4.2/ardftsrc-rs-aarch64-apple-darwin.tar.xz"
      sha256 "51fa8c0e08ba3cab6ca2e3071a2c146867c23f4b9eceb3b1797938a59edfaf48"
    end
    if Hardware::CPU.intel?
      url "https://github.com/phayes/ardftsrc-rs/releases/download/v0.4.2/ardftsrc-rs-x86_64-apple-darwin.tar.xz"
      sha256 "570bdbd57b7ba08bfa23811ebf7474277836df0170556b321093834b4323c7ef"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/phayes/ardftsrc-rs/releases/download/v0.4.2/ardftsrc-rs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "29346c7bbdc5159d70cf1d905d81ee87991f7af90d4b78ba10414962ab3ebcb4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/phayes/ardftsrc-rs/releases/download/v0.4.2/ardftsrc-rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f432caaa1424040adea10d4bf7f76e9d15f25af98d554c534805bdf965ec8913"
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
      bin.install "ardftsrc-rs"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "ardftsrc-rs"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "ardftsrc-rs"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "ardftsrc-rs"
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

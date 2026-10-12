class ArdftsrcRs < Formula
  desc "Command-line wav and flac sample-rate converter powered by ardftsrc."
  homepage "https://github.com/phayes/ardftsrc-rs"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/phayes/ardftsrc-rs/releases/download/v0.3.0/ardftsrc-rs-aarch64-apple-darwin.tar.xz"
      sha256 "22831875882d3d1066b0ed3ec12ea4bd4dbbe2940a95025906e6a927aa525793"
    end
    if Hardware::CPU.intel?
      url "https://github.com/phayes/ardftsrc-rs/releases/download/v0.3.0/ardftsrc-rs-x86_64-apple-darwin.tar.xz"
      sha256 "b37c3f16f7160121cb39ca99bdad1253d9e58154f914e5e8e62f459f3652edcb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/phayes/ardftsrc-rs/releases/download/v0.3.0/ardftsrc-rs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a3f88faccddef29cea58661c0ba58251c85637447ddde42abe1f8440543ed964"
    end
    if Hardware::CPU.intel?
      url "https://github.com/phayes/ardftsrc-rs/releases/download/v0.3.0/ardftsrc-rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ce8edfb15c8c6eeff4e769655a0a7350dd148b6f03fad4fe022e850d9bda5732"
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

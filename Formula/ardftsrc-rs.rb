class ArdftsrcRs < Formula
  desc "Command-line wav and flac sample-rate converter powered by ardftsrc."
  homepage "https://github.com/phayes/ardftsrc-rs"
  version "0.4.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/phayes/ardftsrc-rs/releases/download/v0.4.3/ardftsrc-rs-aarch64-apple-darwin.tar.xz"
      sha256 "5253926d2d3d8a834473eb6f5c2a76a8e8ec96f0b5b15ea1805d5160d568b8f6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/phayes/ardftsrc-rs/releases/download/v0.4.3/ardftsrc-rs-x86_64-apple-darwin.tar.xz"
      sha256 "cb8cce41e529ed06cbb1acb4d78945063263c28973dcdf7a173c9b10ad3fed95"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/phayes/ardftsrc-rs/releases/download/v0.4.3/ardftsrc-rs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "50b6f0e7c9723e8efa9459ba623e534a4b00116448ee15dd7503877b6a8d5bf0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/phayes/ardftsrc-rs/releases/download/v0.4.3/ardftsrc-rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7da481ab3b6da623fdef859a96ca820498e346809456b7124a4817e05df93894"
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

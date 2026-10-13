class ArdftsrcRs < Formula
  desc "Command-line wav and flac sample-rate converter powered by ardftsrc."
  homepage "https://github.com/phayes/ardftsrc-rs"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/phayes/ardftsrc-rs/releases/download/v0.4.0/ardftsrc-rs-aarch64-apple-darwin.tar.xz"
      sha256 "a967391ceac8fd16d8c3fa9aea18991bc83a3625cbf9aa723b161f4b9d524430"
    end
    if Hardware::CPU.intel?
      url "https://github.com/phayes/ardftsrc-rs/releases/download/v0.4.0/ardftsrc-rs-x86_64-apple-darwin.tar.xz"
      sha256 "dd7b01fe25d0d740b4fea9db14134a3bd6bf09f986608eadb3a2e09c672b9967"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/phayes/ardftsrc-rs/releases/download/v0.4.0/ardftsrc-rs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "02c45140beaf29d61830cc9e1441b59dd9000d32b62495d4c16e591499068d76"
    end
    if Hardware::CPU.intel?
      url "https://github.com/phayes/ardftsrc-rs/releases/download/v0.4.0/ardftsrc-rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "eb03ab11c50be2c09339f1ee95c5d0a344b46ef6bba1665d48db9b7d04e5f2df"
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

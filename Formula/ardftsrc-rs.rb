class ArdftsrcRs < Formula
  desc "Command-line wav and flac sample-rate converter powered by ardftsrc."
  homepage "https://github.com/phayes/ardftsrc-rs"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/phayes/ardftsrc-rs/releases/download/v0.1.1/ardftsrc-rs-aarch64-apple-darwin.tar.xz"
      sha256 "4210de6cf1ccaf994ba7d8c15c021f0e9eb4af7c7111fa6f97ebb9977b220f7b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/phayes/ardftsrc-rs/releases/download/v0.1.1/ardftsrc-rs-x86_64-apple-darwin.tar.xz"
      sha256 "b3e361e9b605003de9daec35f962c545703ff82da10ca3e612707f4178909883"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/phayes/ardftsrc-rs/releases/download/v0.1.1/ardftsrc-rs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f0292ebca6cae15dff0146be7348a8d1dd6ca4c81fbe081c95411e9b6c4994bc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/phayes/ardftsrc-rs/releases/download/v0.1.1/ardftsrc-rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3c7fedebb2bdc2b90d70e70446e343bacf7745617ccc2747acbf3898d8f335ca"
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

class VelociCli < Formula
  desc "Command-line interface for Veloci Redactor: redact secrets and PII from text and structured files"
  homepage "https://github.com/phayes/velociredactor"
  version "0.3.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/phayes/velociredactor/releases/download/v0.3.2/veloci-cli-aarch64-apple-darwin.tar.xz"
      sha256 "3d709b4d1d9f910b186bf405815e2c8c9ab47b0873bf16c4d178ca6209469f34"
    end
    if Hardware::CPU.intel?
      url "https://github.com/phayes/velociredactor/releases/download/v0.3.2/veloci-cli-x86_64-apple-darwin.tar.xz"
      sha256 "22c07605bedc6e8288dceba6c4909c3618d1b2a4fbcf6faad9f2ea5458967b25"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/phayes/velociredactor/releases/download/v0.3.2/veloci-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5b4f0b66863ddac9759c1361db7e84918f7f3a9d23782161b4fa3f0c268c570f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/phayes/velociredactor/releases/download/v0.3.2/veloci-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fa9ff97d5b0ce4f00b00972f2b5bd8362247d6f5fbc712378562ed99aa621d16"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "veloci"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "veloci"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "veloci"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "veloci"
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

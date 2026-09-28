class VelociCli < Formula
  desc "Command-line interface for Veloci Redactor: redact secrets and PII from text and structured files"
  homepage "https://github.com/phayes/velociredactor"
  version "0.3.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/phayes/velociredactor/releases/download/v0.3.3/veloci-cli-aarch64-apple-darwin.tar.xz"
      sha256 "9e3df022fc618131235e884cf4ca1137d454d7cf4131dd0da57cddc8c5ddd724"
    end
    if Hardware::CPU.intel?
      url "https://github.com/phayes/velociredactor/releases/download/v0.3.3/veloci-cli-x86_64-apple-darwin.tar.xz"
      sha256 "096fc055793bfb62f9ebd96a51653fcc6c936a57e8e515153df0a67a4235d35a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/phayes/velociredactor/releases/download/v0.3.3/veloci-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ea03bd9a3dc83b1dfd7c8cf3921264493642af7cde5c5366e3feace0984b727d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/phayes/velociredactor/releases/download/v0.3.3/veloci-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "51bf3f4ffbb7320d0a414bcf3592c41d29cc6865d14b2ec35cfe61361fef61bd"
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

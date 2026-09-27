class VelociCli < Formula
  desc "Command-line interface for Veloci Redactor: redact secrets and PII from text and structured files"
  homepage "https://github.com/phayes/velociredactor"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/phayes/velociredactor/releases/download/v0.3.0/veloci-cli-aarch64-apple-darwin.tar.xz"
      sha256 "7492fe85e9962c9e36c3fbb225f7b8b849db1e599519a7f2ef52a7cf248a20c6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/phayes/velociredactor/releases/download/v0.3.0/veloci-cli-x86_64-apple-darwin.tar.xz"
      sha256 "e1dfc2b5244cde3016784703aa36bc149fcbc615e59f3a2b67cc3c2618009e6a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/phayes/velociredactor/releases/download/v0.3.0/veloci-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "01fbcae7a2aba08cb22018256f806eaf91a015c8c764f3feb24832e1c8e96ccf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/phayes/velociredactor/releases/download/v0.3.0/veloci-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "29f3d35be253e433f2e8164124f99534599466cce9c26a35b9ba1a8d08ccd899"
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

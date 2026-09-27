class VelociCli < Formula
  desc "Command-line interface for Veloci Redactor: redact secrets and PII from text and structured files"
  homepage "https://github.com/phayes/velociredactor"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/phayes/velociredactor/releases/download/v0.3.1/veloci-cli-aarch64-apple-darwin.tar.xz"
      sha256 "e40e42e50aaeb383fc4b91caa0fb2138d15eb1d4c49ac66bff069f2e8236cba4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/phayes/velociredactor/releases/download/v0.3.1/veloci-cli-x86_64-apple-darwin.tar.xz"
      sha256 "aa76946ce2f2f84fa527a9f5943f3cf6c193d4fe6729f2b69e8ce7bcd4ab0e15"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/phayes/velociredactor/releases/download/v0.3.1/veloci-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ff9f157ca1768908b73637ec68833a86cecebc7f3f33c5b4973d7649d61ff8f4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/phayes/velociredactor/releases/download/v0.3.1/veloci-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b725db4b1a0c01a0c138aecea534e3d1ca5613cbca0be8d1e59f34712bff16c7"
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

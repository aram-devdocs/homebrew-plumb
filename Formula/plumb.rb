class Plumb < Formula
  desc "Plumb command-line interface — the `plumb` binary."
  homepage "https://plumb.aramhammoudeh.com"
  version "0.0.13"
  on_macos do
    on_intel do
      odie <<~EOS
        Plumb does not yet ship native Intel Mac (x86_64) binaries.
        Install via Cargo instead:

          cargo install plumb-cli

        Tracking: https://github.com/aram-devdocs/plumb/issues/269
      EOS
    end
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aram-devdocs/plumb/releases/download/v0.0.13/plumb-cli-aarch64-apple-darwin.tar.xz"
      sha256 "4104ed688b78069bc8b9c6529bc8ebabbedfc76db8a9b61ee93866d2688baf84"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/aram-devdocs/plumb/releases/download/v0.0.13/plumb-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7da901b51295573462526ccccf9aad3d2b5dae40bcb5dbfc6771275316e092f1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aram-devdocs/plumb/releases/download/v0.0.13/plumb-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "59740d1dd377566a7064959784a722946e95465da836ab8c9dbc3b2ea998a605"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static": {}
  }

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
      bin.install "plumb"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "plumb"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "plumb"
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

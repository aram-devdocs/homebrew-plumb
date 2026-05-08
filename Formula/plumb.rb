class Plumb < Formula
  desc "Plumb command-line interface — the `plumb` binary."
  homepage "https://plumb.aramhammoudeh.com"
  version "0.0.12"

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
      url "https://github.com/aram-devdocs/plumb/releases/download/v0.0.12/plumb-cli-aarch64-apple-darwin.tar.xz"
      sha256 "8f3e64fbc442fac7d8f9f41bb3e4bd4a187e750d3bdb02b20de44d89463e0441"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/aram-devdocs/plumb/releases/download/v0.0.12/plumb-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "12d35c8c695f096fef955881a80269b85f0a57f0651a80766eab776c201f32fb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aram-devdocs/plumb/releases/download/v0.0.12/plumb-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6cedd4e349af802e38adabba6fbe9b9a6ea2a486609103a18a50d5628fc56fff"
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

# homebrew-plumb

Homebrew tap for [Plumb](https://github.com/aram-devdocs/plumb), a deterministic
design-system linter for rendered websites.

## Install

```sh
brew install aram-devdocs/plumb/plumb
```

This installs the `plumb` command-line binary. Run `plumb --help` to confirm
the install, or see the [docs](https://plumb.aramhammoudeh.com) for usage.

## Supported platforms

The tap publishes prebuilt binaries for:

- Apple Silicon macOS (`aarch64-apple-darwin`)
- Linux x86_64 (`x86_64-unknown-linux-gnu`)
- Linux ARM64 (`aarch64-unknown-linux-gnu`)

### Intel Mac

Native Intel Mac (`x86_64-apple-darwin`) binaries are not yet shipped.
On an Intel Mac, `brew install` exits with a message pointing here.
Install via Cargo instead:

```sh
cargo install plumb-cli
```

Tracking issue: <https://github.com/aram-devdocs/plumb/issues/269>.

## How this tap is published

Plumb's release pipeline uses [`cargo-dist`](https://github.com/axodotdev/cargo-dist).
On every tagged release in [`aram-devdocs/plumb`](https://github.com/aram-devdocs/plumb),
cargo-dist emits an updated `Formula/plumb.rb` and the release workflow's
`publish-homebrew` job pushes it here. You SHOULD NOT edit `Formula/plumb.rb`
by hand outside of the patches that backstop cargo-dist's output (such as
the README and integrity hashes added in this repo's history).

## Links

- Main repo: <https://github.com/aram-devdocs/plumb>
- Documentation: <https://plumb.aramhammoudeh.com>
- Issue tracker: <https://github.com/aram-devdocs/plumb/issues>

## License

MIT OR Apache-2.0, matching the upstream `plumb` project.

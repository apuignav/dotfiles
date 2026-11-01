# herdr and Collie

Installs [herdr](https://github.com/herdrdev/herdr) (terminal multiplexer for coding agents) and [Collie](https://github.com/AltanS/collie) (phone PWA that mirrors herdr sessions) on the Mac. Wired in through `deploy/configs/herdr.yaml`, which the `mac` profile runs last.

## What it installs

`herdr/install.sh` is idempotent and never uses `curl | sh`. Every download is checked against a pinned sha256 before use.

- herdr into `~/.local/bin/herdr`. Skipped if an equal or newer version is already installed, so it never downgrades (herdr self-updates with `herdr update`).
- The herdr Claude Code hook, via `herdr integration install claude`.
- Collie in the official standalone layout: `~/.local/share/collie/versions/<version>`, a `current` symlink, and `collie link`. Skipped if `versions/` already exists (Collie self-updates with `collie update`).

It does not start herdr or Collie, and installs no LaunchAgent. Supports arm64 and x86_64.

## Bumping pinned versions

1. Find the new release on the herdr or Collie GitHub releases page.
2. Download the macOS assets for both architectures (`herdr-macos-aarch64`, `herdr-macos-x86_64`; `collie-<v>-macos-arm64.tar.gz`, `collie-<v>-macos-x64.tar.gz`).
3. Compute each checksum with `shasum -a 256 <file>`.
4. In `herdr/install.sh`, update the version variable and both sha256 variables for that tool.
5. Keep these values in sync with the server's `deploy/herdr/deploy.sh` in the homelab repo.

## Joining the Collie crew (manual)

The laptop is a crew member. The lead is the home server at `https://server.tail8fef08.ts.net`.

1. On the laptop: `COLLIE_MUX=herdr collie start`. This creates the Collie config file at `~/.config/herdr/plugins/config/herdr.collie/.env`.
2. Join the crew, piping the token straight from the server so it never appears on screen or in a process listing:

    ```
    ssh home '~/.local/bin/collie crew invite' | collie crew join https://server.tail8fef08.ts.net - --label dc10 --address <laptop-tailnet-name>:8787
    ```

    The invite token is single-use and valid for 10 minutes. The full path to `collie` on the server is needed because `~/.local/bin` may not be on the PATH of a non-interactive ssh session.
3. Bind the member to its Tailscale address. By default it listens on `127.0.0.1`, which the lead can't reach. Add these two lines to the `.env` file above, with the value from `tailscale ip -4`:

    ```
    COLLIE_HOST=<output of tailscale ip -4>
    COLLIE_ALLOW_NON_LOOPBACK_BIND=1
    ```

    Then run `collie restart` on the laptop. The port only accepts the lead: it uses pinned mutual TLS, so browsers and other tailnet devices are refused. The IP is machine-specific, so it stays out of the repo.
4. On the server: `collie restart`, then `collie crew status`. The member should show `link reachable`.

A member has no front door of its own. After joining, Collie removes the laptop's `tailscale serve` mapping and publishes nothing, so `tailscale serve status` shows "No serve config". Don't add `tailscale serve` or Funnel for Collie.

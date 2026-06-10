"""Open the given file (optionally at a line/range) on its remote forge.

Usage: open-in-forge <file> [start_line] [end_line]
"""

import subprocess
import sys
import webbrowser
from pathlib import Path


def git(*args, cwd):
    return subprocess.run(
        ["git", *args], cwd=cwd, check=True, text=True, capture_output=True
    ).stdout.strip()


def to_https(url):
    """Normalize any git remote URL to an https base, sans .git."""
    url = url.removesuffix(".git")
    if url.startswith("git@"):  # git@host:owner/repo
        host, _, path = url.removeprefix("git@").partition(":")
        return f"https://{host}/{path}"
    if url.startswith("ssh://"):
        return "https://" + url.removeprefix("ssh://git@")
    return url


def main():
    if len(sys.argv) < 2:
        sys.exit("usage: open-in-forge <file> [line]")

    path = Path(sys.argv[1]).resolve()
    start = sys.argv[2] if len(sys.argv) > 2 else None
    end = sys.argv[3] if len(sys.argv) > 3 else start
    repo = path.parent

    root = Path(git("rev-parse", "--show-toplevel", cwd=repo))
    rel = path.relative_to(root)

    ref = git("rev-parse", "--abbrev-ref", "HEAD", cwd=repo)
    if ref == "HEAD":  # detached: pin to the commit
        ref = git("rev-parse", "HEAD", cwd=repo)

    try:
        remote = git("config", "--get", f"branch.{ref}.remote", cwd=repo)
    except subprocess.CalledProcessError:
        remote = "origin"

    base = to_https(git("remote", "get-url", remote, cwd=repo))

    # GitLab nests blobs under /-/; GitHub (and most others) use /blob/.
    blob = "/-/blob/" if "gitlab" in base else "/blob/"
    target = f"{base}{blob}{ref}/{rel}"
    if start:
        target += f"#L{start}"
        if end and end != start:
            # GitHub: #L10-L20; GitLab: #L10-20
            target += f"-{end}" if "gitlab" in base else f"-L{end}"

    webbrowser.open(target)


if __name__ == "__main__":
    main()

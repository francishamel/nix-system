"""Open the given file (optionally at a line/range) on its remote forge.

Usage: open-in-forge [--blame] <file> [start_line] [end_line]
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
    argv = sys.argv[1:]
    blame = "--blame" in argv
    argv = [a for a in argv if a != "--blame"]
    if not argv:
        sys.exit("usage: open-in-forge [--blame] <file> [line]")

    path = Path(argv[0]).resolve()
    start = argv[1] if len(argv) > 1 else None
    end = argv[2] if len(argv) > 2 else start
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

    # GitLab nests paths under /-/; GitHub (and most others) don't.
    view = "blame" if blame else "blob"
    prefix = f"/-/{view}/" if "gitlab" in base else f"/{view}/"
    target = f"{base}{prefix}{ref}/{rel}"
    if start:
        target += f"#L{start}"
        if end and end != start:
            # GitHub: #L10-L20; GitLab: #L10-20
            target += f"-{end}" if "gitlab" in base else f"-L{end}"

    webbrowser.open(target)


if __name__ == "__main__":
    main()

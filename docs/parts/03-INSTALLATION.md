
## INSTALLATION

### Dependencies
- [git](https://git-scm.com/)
- [docopts (Latest Python release)](https://github.com/docopt/docopts)

### Recommend methods [WIP]

If you're on Arch Linux `git-bookmark` is available on AUR:
- [AUR Package](https://aur.archlinux.org/packages/git-bookmark/)

### Alternative package managers

Alternatively you can use a bash package manager to install it, like [basher](https://github.com/basherpm/basher) or [bpkg](https://github.com/bpkg/bpkg).

```
   bpkg install qu4tro/git-bookmark # -g for global install
   # or
   basher install qu4tro/git-bookmark
```
Neither is instructed to fetch the runtime dependencies, so you will need to install them separately.
To install `docopts`:
```
   pip install docopts
```
And git shouldn't be a problem installing if you're reading this.

### Manual setup

You can also install it manually. We first need the source. We can get the latest release tarball on the Releases page or simply do a `git clone` if we want the latest commit.

Once we've extracted the tarball (or cd'd into the repo), just run:

   `sudo make install`

Finally, you can install the script by just copying it somewhere on PATH.
It won't install the manpages and set the proper permissions, but it should work fine.

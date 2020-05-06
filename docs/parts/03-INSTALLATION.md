
## INSTALLATION

### Dependencies
- [git](https://git-scm.com/)
- [docopts (Latest Python release)](https://github.com/docopt/docopts)

You'll need to install them when installing, with all, but the recommended installation methods.
To install `docopts`:
```
   pip install docopts
```
And git shouldn't be a problem installing if you're reading this.

### Recommend methods [WIP]

If you're on Arch Linux `git-bookmark` is available on AUR:
- [AUR Package](https://aur.archlinux.org/packages/git-bookmark/)


### Manual setup

You can also install it manually. We first need the source. We can get the latest release tarball on the Releases page or simply do a `git clone` if we want the latest commit.

Once we've extracted the tarball (or cd'd into the repo), just run:

   `sudo make install`

### Really manual setup

You can install the script by wget'ing it and copying it somewhere on PATH.
It won't install the manpages and set the proper permissions, but it should work fine.

### Alternative package managers

Alternatively you can use a bash package manager to install it, like [basher](https://github.com/basherpm/basher) or [bpkg](https://github.com/bpkg/bpkg).

```
   bpkg install qu4tro/git-bookmark # -g for global install
   # or
   basher install qu4tro/git-bookmark
```

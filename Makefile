.PHONY: all help lint test install uninstall
PREFIX ?= /usr/local
DESTDIR ?=
BINDIR ?= $(PREFIX)/bin
MANDIR ?= $(PREFIX)/share/man
TASK_DONE = echo -e "\n✓ $@ done\n"

all help:
	@echo "Usage:"
	@echo "  make lint"
	@echo "  make test"
	@echo "  make docs"
	@echo "  make install"
	@echo "  make uninstall"


docs: docs/git-bookmark.1 docs/git-bookmark.1.html docs/index.html
	@$(TASK_DONE)

docs/git-bookmark.md: README.md
	@mkdir -p docs
	@# slice from INSTALLATION section to DESCRIPTION section
	@sed -e "$$(cat README.md | grep INSTALLATION -n | cut -d: -f1),$$(cat README.md | grep DESCRIPTION -n -B1 | head -1 | cut -d- -f1)d" README.md > "$@"
	@echo "Copy partial README.md to $@"

docs/git-bookmark.1 docs/git-bookmark.1.html: docs/git-bookmark.md
	ronn "$<"

docs/index.html: docs/git-bookmark.1.html
	cp "$<" "$@"

lint:
	shellcheck -s bash git-bookmark
	@$(TASK_DONE)

test: test/test_helper/bats-support test/test_helper/bats-assert
	bats test

test/test_helper/bats-support:
	git clone https://github.com/bats-core/bats-support "$@"

test/test_helper/bats-assert:
	git clone https://github.com/bats-core/bats-assert "$@"

clean:
	rm -rf docs test/test_helper/

install:
	@install -v -d "$(DESTDIR)$(MANDIR)/man1"
	@install -v -d "$(DESTDIR)$(BINDIR)/"
	@install -v -m 0755 "git-bookmark" "$(DESTDIR)$(BINDIR)/git-bookmark"
	@install -v -m 0755 "git-bookmark" "$(DESTDIR)$(BINDIR)/git-bk"
	@install -v -m 0644 docs/git-bookmark.1 "$(DESTDIR)$(MANDIR)/man1/git-bookmark.1"
	@$(TASK_DONE)


uninstall:
	@rm -vrf \
		"$(DESTDIR)$(BINDIR)/git-bookmark" \
		"$(DESTDIR)$(BINDIR)/git-bk" \
		"$(DESTDIR)$(MANDIR)/man1/git-bookmark.1"
	@$(TASK_DONE)

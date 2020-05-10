.PHONY: all help lint test install uninstall
PREFIX ?= /usr/local
DESTDIR ?=
BINDIR ?= $(PREFIX)/bin
MANDIR ?= $(PREFIX)/share/man
TASK_DONE = echo -e "\n✓ $@ done\n"

all help:
	@echo "Usage:"
	@echo "  make lint"
	@echo "  make docs"
	@echo "  make test"
	@echo "  make test-seq"
	@echo "  make install"
	@echo "  make uninstall"


docs: docs/git-bookmark.1 docs/git-bookmark.1.html docs/index.html README.md
	@$(TASK_DONE)

README.md: docs/parts
	@cat docs/parts/0[01]-GH-*.md docs/parts/0[234567]* > "$@"

docs/git-bookmark.md: docs/parts
	@cat docs/parts/0[01]-MAN-*.md docs/parts/0[24567]* > "$@"

docs/git-bookmark.1 docs/git-bookmark.1.html: docs/git-bookmark.md
	ronn "$<"

docs/index.html: docs/git-bookmark.1.html
	cp "$<" "$@"

lint:
	@shellcheck --shell bash git-bookmark
	@$(TASK_DONE)

test: test/test_helper/bats-support test/test_helper/bats-assert
	@bats test --jobs 8
	@$(TASK_DONE)

test-seq: test/test_helper/bats-support test/test_helper/bats-assert
	@bats test
	@$(TASK_DONE)

test/test_helper/bats-support:
	git clone https://github.com/bats-core/bats-support "$@"

test/test_helper/bats-assert:
	git clone https://github.com/bats-core/bats-assert "$@"

clean:
	rm -f docs/git-bookmark.md docs/git-bookmark.1
	rm -f docs/index.html docs/git-bookmark.1.html
	rm -f README.md
	rm -rf test/test_helper/

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

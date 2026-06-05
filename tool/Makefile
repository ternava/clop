# Makefile for clop — Count CLi OPtions
#
# This Makefile lives in tool/ alongside the clop script and its tests, so the
# tool is fully self-contained. The Zola project page lives one level up.
#
# Common targets:
#   make test               		run the test suite
#   make install            		install clop (default prefix: /usr/local)
#   make uninstall          		remove an installed clop
#   make PREFIX=~/.local install   	install into your home directory
#   make site               		publish clop into ../static so Zola can serve it
#
# Packagers can override PREFIX, BINDIR and DESTDIR in the usual way.

PREFIX  ?= /usr/local
BINDIR  ?= $(PREFIX)/bin
DESTDIR ?=

INSTALL ?= install

# Where the Zola site expects the downloadable script. This published copy is
# generated from this directory's clop and is not tracked in git.
SITE_STATIC ?= ../static
SITE_COPY    = $(SITE_STATIC)/clop

.PHONY: all test install uninstall lint site clean

all:
	@echo "Nothing to build. Try: make test | make install | make site"

test:
	./tests/run_tests.sh

install: clop
	$(INSTALL) -d "$(DESTDIR)$(BINDIR)"
	$(INSTALL) -m 0755 clop "$(DESTDIR)$(BINDIR)/clop"
	@echo "Installed clop to $(DESTDIR)$(BINDIR)/clop"

uninstall:
	rm -f "$(DESTDIR)$(BINDIR)/clop"
	@echo "Removed $(DESTDIR)$(BINDIR)/clop"

# Publish the script into the Zola static directory so the project page can
# offer it for download at /clop/clop. Run before `zola serve` / `zola build`.
site: clop
	$(INSTALL) -d "$(SITE_STATIC)"
	$(INSTALL) -m 0755 clop "$(SITE_COPY)"
	@echo "Published clop to $(SITE_COPY)"

# Optional static analysis if shellcheck is installed.
lint:
	@command -v shellcheck >/dev/null 2>&1 \
		&& shellcheck clop tests/run_tests.sh \
		|| echo "shellcheck not installed; skipping lint"

clean:
	rm -f "$(SITE_COPY)"
	@echo "Removed generated $(SITE_COPY)"

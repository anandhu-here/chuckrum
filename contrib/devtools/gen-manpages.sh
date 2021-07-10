#!/usr/bin/env bash

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

CHUCKRUMD=${CHUCKRUMD:-$BINDIR/chuckrumd}
CHUCKRUMCLI=${CHUCKRUMCLI:-$BINDIR/chuckrum-cli}
CHUCKRUMTX=${CHUCKRUMTX:-$BINDIR/chuckrum-tx}
CHUCKRUMQT=${CHUCKRUMQT:-$BINDIR/qt/chuckrum-qt}

[ ! -x $CHUCKRUMD ] && echo "$CHUCKRUMD not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
CKMVER=($($CHUCKRUMCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for chuckrumd if --version-string is not set,
# but has different outcomes for chuckrum-qt and chuckrum-cli.
echo "[COPYRIGHT]" > footer.h2m
$CHUCKRUMD --version | sed -n '1!p' >> footer.h2m

for cmd in $CHUCKRUMD $CHUCKRUMCLI $CHUCKRUMTX $CHUCKRUMQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${CKMVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${CKMVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m

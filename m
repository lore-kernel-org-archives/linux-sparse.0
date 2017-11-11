From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 00/38] Makefile reognization
Date: Sat, 11 Nov 2017 15:23:59 +0100
Message-ID: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:54637 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbdKKOYu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 09:24:50 -0500
Received: by mail-wm0-f42.google.com with SMTP id r68so7597032wmr.3
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 06:24:49 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

The goal of this series is to reorganize sparse's Makefile
in order to offer a few features asked by the distros:
1) allow CFLAGS & CPPFLAGS to be taken from the command line
2) allow PREFIX to be taken from the environment
Support for pkg-config is removed as well as some old crufts.

This cleanup is based on a previous series by Uwe Kleine-König
and further inspired by a patch and a need from Jeff Layton.

The changes since v1 are:
*) fold the two patches concerning the removal of shared lib support
*) remove the patch using git-clean for 'make clean'

The changes since v2 are:
*) change a commit message to make explicit the fact that
   quiet's commands abbreviated part are also issued for V=1
*) add a convenience rule for running a single test via:
        make validation/<name-of-testfile>.t

The changes since v3 are:
*) make the name 'local.mk' be configurable instead of
   the renaming that was done.
*) move '-fno-strict-aliasing' out of the overridable CFLAGS
*) rename the ...{_OBJS,_LDFLAGS,_LDLIBS} to ...{-objs,-ldflags,-ldlibs}
   to be consistent about the private 'cflags'.

The series is available at:
  git://github.com/lucvoo/sparse.git make-cleanup-v4

Luc Van Oostenryck (32):
  build: fix effectiveness of generated dependencies
  build: remove unused support for pkgconfig
  build: use '-objs' instead of '_EXTRA_DEPS'
  build: use '-ldlibs' instead of '_EXTRA_OBJS'
  build: allow target-specific CFLAGS, CPPFLAGS, LDFLAGS & LDLIBS
  build: allow CFLAGS & friends from command line
  build: avoid rule-specific CFLAGS
  build: use $LIBS directly in the dependency list
  build: no need to use wildcards for generated dependencies
  build: reuse rule for ALL_OBJS
  build: CHECKER_FLAGS=-Wno-vla for all targets
  build: move tests near their use
  build: add note about overwritable vars
  build: remove references to unexisting pre-process.h
  build: move clean & clean-check together
  build: make clean targets quieter
  build: remove rule for shared lib, it's unused
  build: normalize rules
  build: remove the dist rule since unused
  build: use one line per item
  build: allow the name 'local.mk' to be configurable via the environment
  build: use standard rules for install
  build: remove unused QUIET_INST_SH
  build: let quiet commands use less indentation
  build: simplify quiet commands
  build: simplify clean pattern
  build: add *.o to clean-check pattern
  build: avoid foreach
  build: reorg & add comment
  build: use a single space before assignments
  build: add rule to run a single test
  build: let -fno-strict-aliasing be a mandatory flag

Uwe Kleine-König (6):
  build: make PREFIX overwritable from the environment
  build: put comment about local.mk to the place where it is included
  build: drop BASIC_CFLAGS and ALL_CFLAGS
  build: drop -g from LDFLAGS
  build: pass CPPFLAGS to compiler
  build: only generate version.h when needed

 .gitignore   |   3 +-
 Makefile     | 322 ++++++++++++++++++++++++++++++-----------------------------
 sparse.pc.in |   9 --
 3 files changed, 163 insertions(+), 171 deletions(-)
 delete mode 100644 sparse.pc.in

-- 
CC: Uwe Kleine-König <uwe@kleine-koenig.org>
CC: Jeff Layton <jlayton@redhat.com>
CC: Josh Triplett <josh@joshtriplett.org>
CC: Ramsay Jones <ramsay@ramsayjones.plus.com>

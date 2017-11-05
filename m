From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 00/36] Makefile reorganization
Date: Sun,  5 Nov 2017 17:24:48 +0100
Message-ID: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:49750 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbdKEQYz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 11:24:55 -0500
Received: by mail-wm0-f51.google.com with SMTP id b189so9449701wmd.4
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 08:24:55 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to reorganize sparse's Makefile
in order to offer a few features asked by the distros:
1) allow CFLAGS & CPPFLAGS to be taken from the command line
2) allow PREFIX to be taken from the environment
Support for pkg-config is removed as well as some old crufts.

This cleanup is based on a previous series by Uwe Kleine-König
and further inspired by a patch and a need from Jeff Layton.

The series is available for review & testing at:
  git://github.com/lucvoo/sparse.git make-cleanup

-- Luc Van Oostenryck

Luc Van Oostenryck (30):
  build: fix effectiveness of generated dependencies
  build: remove unused support for pkgconfig
  build: use '_OBJS' instead of '_EXTRA_DEPS'
  build: use '_LDLIBS' instead of '_EXTRA_OBJS'
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
  build: no need to clean *.so and SLIB_FILE
  build: move clean & clean-check together
  build: make clean targets quieter
  build: remove rule for shared lib, it's unused
  build: normalize rules
  build: remove the dist rule since unused
  build: use one line per item
  build: use a dot file name instead of local.mk: .sparse.mk
  build: use git-clean
  build: use standard rules for install
  build: remove unused QUIET_INST_SH
  build: let quiet commands use less indentation
  build: simpler logic for quiet commands
  build: avoid foreach
  build: reorg & add comment
  build: use a single space before assignments

Uwe Kleine-König (6):
  build: make PREFIX overwritable from the environment
  build: put comment about local.mk to the place where it is included
  build: drop BASIC_CFLAGS and ALL_CFLAGS
  build: drop -g from LDFLAGS
  build: pass CPPFLAGS to compiler
  build: only generate version.h when needed

 .gitignore   |   4 +-
 Makefile     | 309 ++++++++++++++++++++++++++++-------------------------------
 sparse.pc.in |   9 --
 3 files changed, 150 insertions(+), 172 deletions(-)
 delete mode 100644 sparse.pc.in

-- 
2.14.0


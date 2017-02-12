From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 0/3] builtins expansion
Date: Sun, 12 Feb 2017 16:10:57 +0100
Message-ID: <20170212151100.15868-1-luc.vanoostenryck@gmail.com>
References: <20170212150332.33xlxmzohgb7hrpp@macpro.local>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35238 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751225AbdBLPMU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Feb 2017 10:12:20 -0500
Received: by mail-wr0-f193.google.com with SMTP id o16so20559288wra.2
        for <linux-sparse@vger.kernel.org>; Sun, 12 Feb 2017 07:12:19 -0800 (PST)
In-Reply-To: <20170212150332.33xlxmzohgb7hrpp@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Johannes Berg <johannes@sipsolutions.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This serie solves the problem of the expansion of some builtins
like __builtin_bswap16() which gcc consider as an integer constant
expression when the arg is itself an integer constant.
Such builtins are used as such in the kernel and their non-expansion
create undesirable warnings from sparse.

This serie needs to be applied on top of Johannes Berg's patch
concerning the same problem and the tests depend on the testsuite
extensions posted previously.

Change since v1:
- simpler and more generic way to share the eval/expand ops
  thanks to Christopher Li
- small changes in the log messages
- change the variable name in the bswap expansion method.
- small reorganization of the test files

Luc Van Oostenryck (3):
  move evaluation & expansion of builtins in a separate file
  let identical symbols share their evaluate/expand methods
  expand __builtin_bswap*() with constant args

 Makefile                                           |   1 +
 builtin.c                                          | 240 +++++++++++++++++++++
 expand.c                                           |  24 +--
 expand.h                                           |  34 +++
 lib.c                                              |  35 +--
 lib.h                                              |   5 +
 parse.c                                            |   4 +-
 symbol.c                                           | 160 +-------------
 symbol.h                                           |   3 +-
 validation/builtin-args-checking.c                 |  45 ++++
 ...in-constant-eval.c => builtin-bswap-constant.c} |   2 +-
 validation/builtin-bswap-variable.c                |  32 +++
 12 files changed, 367 insertions(+), 218 deletions(-)
 create mode 100644 builtin.c
 create mode 100644 expand.h
 create mode 100644 validation/builtin-args-checking.c
 rename validation/{builtin-constant-eval.c => builtin-bswap-constant.c} (93%)
 create mode 100644 validation/builtin-bswap-variable.c

-- 
2.11.0


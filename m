From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] builtins expansion
Date: Mon, 23 Jan 2017 22:37:25 +0100
Message-ID: <20170123213728.89900-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33138 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdAWVhl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 23 Jan 2017 16:37:41 -0500
Received: by mail-wm0-f67.google.com with SMTP id r144so29591811wme.0
        for <linux-sparse@vger.kernel.org>; Mon, 23 Jan 2017 13:37:40 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This serie propose a clean solution to the expansion of some builtins
like __builtin_bswap16() which gcc consider as an integer constant
expression when the arg is itself an integer constant and is used as
such in the kernel in code like:
	#define htons(x) __builtin_bswap16(x)
	...
	switch (protocol) {
	case htons(ETH_P_IPV6):
		...

This serie needs to be applied on top of Johannes Berg's patch
concerning the same problem and the tests depends on the testsuite
extensions posted previously.

Alternatively, this serie can also be found as:
  git://github.com/lucvoo/sparse.git sent/builtin-bswap
      

Luc Van Oostenryck (3):
  move evaluation & expansion of builtins in a separate file
  allow builtins to have prototype and evaluate/expand methods
  expand __builtin_bswap*() with constant args

 Makefile                            |   1 +
 builtin.c                           | 241 ++++++++++++++++++++++++++++++++++++
 evaluate.c                          |   6 +
 expand.c                            |  24 +---
 expand.h                            |  34 +++++
 lib.c                               |  35 +-----
 lib.h                               |   5 +
 symbol.c                            | 160 +-----------------------
 symbol.h                            |   3 +-
 token.h                             |   1 +
 validation/builtin-bswap-constant.c |  48 +++++++
 validation/builtin-bswap.c          |  52 ++++++++
 12 files changed, 394 insertions(+), 216 deletions(-)
 create mode 100644 builtin.c
 create mode 100644 expand.h
 create mode 100644 validation/builtin-bswap-constant.c
 create mode 100644 validation/builtin-bswap.c

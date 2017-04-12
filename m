From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] floating-point literals
Date: Wed, 12 Apr 2017 11:29:25 +0200
Message-ID: <20170412092927.23884-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36772 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751054AbdDLJbd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Apr 2017 05:31:33 -0400
Received: by mail-wm0-f65.google.com with SMTP id q125so5147804wmd.3
        for <linux-sparse@vger.kernel.org>; Wed, 12 Apr 2017 02:31:32 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to simplify the handling
of floating-point literals and as an added bonus, to
make possible the CSE of those literals.

This series is available at:
	git://github.com/lucvoo/sparse.git cse-setfval
based on commit:
	604e7ef9c37100c4ca3dc0b3bee00d114e265684 (fix-f2i-casts)
up to commit:
	c9585071d02590f40175ea90c395d15ef70e9a1e

Luc Van Oostenryck (2):
  add OP_SETFVAL
  CSE: support CSE of floating-point literal

 Documentation/instructions.txt      | 12 ++++++----
 cse.c                               | 11 +++++++++
 linearize.c                         | 18 ++++++++++----
 linearize.h                         |  4 ++++
 liveness.c                          |  1 +
 simplify.c                          |  1 +
 sparse-llvm.c                       | 16 +++++++++----
 validation/cast-constant-to-float.c |  6 ++---
 validation/cast-constants.c         | 20 ++++++++--------
 validation/fp-ops.c                 |  2 +-
 validation/optim/bool-context-fp.c  | 47 +++++++++++++++++++++++++++++++++++++
 validation/optim/cse-setfval.c      | 12 ++++++++++
 12 files changed, 123 insertions(+), 27 deletions(-)
 create mode 100644 validation/optim/bool-context-fp.c
 create mode 100644 validation/optim/cse-setfval.c

-- 
2.12.0


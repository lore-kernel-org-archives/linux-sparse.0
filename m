From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] fix cast to bool
Date: Sun, 11 Dec 2016 22:13:25 +0100
Message-ID: <20161211211328.26735-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33030 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753790AbcLKVQB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 11 Dec 2016 16:16:01 -0500
Received: by mail-wm0-f65.google.com with SMTP id u144so7106836wmu.0
        for <linux-sparse@vger.kernel.org>; Sun, 11 Dec 2016 13:16:00 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This serie fix casting to bool (patch 1) and add two simplifications
which couldn't be done without the fix.

Luc Van Oostenryck (3):
  fix cast to bool
  simplify comparisons followed by an equality test against 0 or 1
  simplify '(x || x)' and '(x && x)'

 evaluate.c                        | 32 +++++++++++++++++
 simplify.c                        | 73 ++++++++++++++++++++++++++++++++++++---
 validation/bool-cast-bad.c        | 27 +++++++++++++++
 validation/bool-cast-explicit.c   | 26 ++++++++++++++
 validation/bool-cast-implicit.c   | 28 +++++++++++++++
 validation/optim/bool-same-args.c | 12 +++++++
 validation/optim/setcc-setcc.c    | 19 ++++++++++
 validation/optim/setcc-seteq.c    | 13 +++++++
 validation/optim/setcc-setne.c    | 13 +++++++
 9 files changed, 239 insertions(+), 4 deletions(-)
 create mode 100644 validation/bool-cast-bad.c
 create mode 100644 validation/bool-cast-explicit.c
 create mode 100644 validation/bool-cast-implicit.c
 create mode 100644 validation/optim/bool-same-args.c
 create mode 100644 validation/optim/setcc-setcc.c
 create mode 100644 validation/optim/setcc-seteq.c
 create mode 100644 validation/optim/setcc-setne.c

-- 
2.10.2


From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] fix examination of base type
Date: Thu, 21 Dec 2017 01:30:15 +0100
Message-ID: <20171221003017.57211-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:41005 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756563AbdLUAaW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 20 Dec 2017 19:30:22 -0500
Received: by mail-wm0-f65.google.com with SMTP id g75so13107390wme.0
        for <linux-sparse@vger.kernel.org>; Wed, 20 Dec 2017 16:30:21 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This two patches series contains a fix for the evaluation
of dereferences which, in some cases, can be done
while the base type is still unexamined.

Luc Van Oostenryck (2):
  add testcases for unexamined base type
  fix: evaluate_dereference() unexamined base type

 evaluate.c                               |  1 +
 validation/linear/deref-ptr-ptr.c        | 26 +++++++++++++++++++++++
 validation/linear/unexamined-base-type.c | 36 ++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)
 create mode 100644 validation/linear/deref-ptr-ptr.c
 create mode 100644 validation/linear/unexamined-base-type.c

-- 
2.15.0


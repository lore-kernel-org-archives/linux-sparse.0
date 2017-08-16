From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 19/29] sssa: add Simple SSA interfaces
Date: Wed, 16 Aug 2017 17:34:45 +0200
Message-ID: <20170816153455.97693-20-luc.vanoostenryck@gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37088 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbdHPPfm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 11:35:42 -0400
Received: by mail-wr0-f194.google.com with SMTP id z91so651050wrc.4
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 08:35:42 -0700 (PDT)
In-Reply-To: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The incoming new method to construct the SSA form that
can be done during the linearization.
It needs only and a small API:
- store_var()
- load_var()
- seal_bb()

These calls can easily be inserted into the current linearization.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ssa.h | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 ssa.h

diff --git a/ssa.h b/ssa.h
new file mode 100644
index 000000000..484c2b418
--- /dev/null
+++ b/ssa.h
@@ -0,0 +1,11 @@
+#ifndef	SSA_H
+#define	SSA_H
+
+#include "linearize.h"
+
+/* ssa.c */
+pseudo_t load_var(struct basic_block *bb, struct symbol *var);
+void store_var(struct basic_block *bb, struct symbol *var, pseudo_t val);
+void seal_bb(struct basic_block *bb);
+
+#endif
-- 
2.14.0


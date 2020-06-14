From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] sindex: use -stdc=gnu99
Date: Sun, 14 Jun 2020 13:35:08 +0200
Message-ID: <20200614113508.19924-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgFNLfl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 14 Jun 2020 07:35:41 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5FBC05BD43
        for <linux-sparse@vger.kernel.org>; Sun, 14 Jun 2020 04:35:41 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id l27so14467670ejc.1
        for <linux-sparse@vger.kernel.org>; Sun, 14 Jun 2020 04:35:41 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Alexey Gladkov <gladkov.alexey@gmail.com>

sindex use C99 for-loops:
	for (int i = 0, ....)

No problem with this but sparse doesn't use this elsewhere yet
and older compilers don't allow C99 by default.

Fix this by adding '-std=gnu99' to the sindex-specific CFLAGS.

Cc: Alexey Gladkov <gladkov.alexey@gmail.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index d1486a0ce373..4bf96f406e5a 100644
--- a/Makefile
+++ b/Makefile
@@ -153,6 +153,7 @@ INST_PROGRAMS += sindex
 INST_MAN1 += sindex.1
 sindex-ldlibs := $(shell $(PKG_CONFIG) --libs sqlite3)
 sindex-cflags := $(shell $(PKG_CONFIG) --cflags sqlite3)
+sindex-cflags += -std=gnu99
 else
 $(warning Your SQLite3 version ($(SQLITE_VERSION)) is too old, 3.24.0 or later is required.)
 endif
-- 
2.27.0

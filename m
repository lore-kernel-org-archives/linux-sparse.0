From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] sindex: minimal version for sqlite3 is 3.24
Date: Sun, 14 Jun 2020 13:30:17 +0200
Message-ID: <20200614113017.19776-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgFNLaw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 14 Jun 2020 07:30:52 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4909CC05BD43
        for <linux-sparse@vger.kernel.org>; Sun, 14 Jun 2020 04:30:52 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id t21so9452169edr.12
        for <linux-sparse@vger.kernel.org>; Sun, 14 Jun 2020 04:30:52 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Alexey Gladkov <gladkov.alexey@gmail.com>

sindex uses the sqlite3_str API which is only present since version
3.24 of SQLite3.

Fix this by adding some checks in the Makefile and refuse to build
it if the requirement is not met.

Cc: Alexey Gladkov <gladkov.alexey@gmail.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Makefile b/Makefile
index f46654e79642..d1486a0ce373 100644
--- a/Makefile
+++ b/Makefile
@@ -145,12 +145,18 @@ endif
 
 HAVE_SQLITE := $(shell $(PKG_CONFIG) --exists sqlite3 2>/dev/null && echo 'yes')
 ifeq ($(HAVE_SQLITE),yes)
+SQLITE_VERSION:=$(shell $(PKG_CONFIG) --modversion sqlite3)
+SQLITE_VNUMBER:=$(shell printf '%d%02d%02d' $(subst ., ,$(SQLITE_VERSION)))
+ifeq ($(shell expr "$(SQLITE_VNUMBER)" '>=' 32400),1)
 PROGRAMS += sindex
 INST_PROGRAMS += sindex
 INST_MAN1 += sindex.1
 sindex-ldlibs := $(shell $(PKG_CONFIG) --libs sqlite3)
 sindex-cflags := $(shell $(PKG_CONFIG) --cflags sqlite3)
 else
+$(warning Your SQLite3 version ($(SQLITE_VERSION)) is too old, 3.24.0 or later is required.)
+endif
+else
 $(warning Your system does not have sqlite3, disabling sindex)
 endif
 
-- 
2.27.0

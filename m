From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 38/38] build: let -fno-strict-aliasing be a mandatory flag
Date: Sat, 11 Nov 2017 15:24:37 +0100
Message-ID: <20171111142437.67359-39-luc.vanoostenryck@gmail.com>
References: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37298 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbdKKO0B (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 09:26:01 -0500
Received: by mail-wm0-f66.google.com with SMTP id b14so7478371wme.2
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 06:26:01 -0800 (PST)
In-Reply-To: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index a2d3e8c89..f26c1f962 100644
--- a/Makefile
+++ b/Makefile
@@ -6,7 +6,7 @@ OS = linux
 
 
 CC = gcc
-CFLAGS = -O2 -finline-functions -fno-strict-aliasing -g
+CFLAGS = -O2 -finline-functions -g
 CFLAGS += -Wall -Wwrite-strings
 LD = gcc
 AR = ar
@@ -79,6 +79,11 @@ INST_MAN1=sparse.1 cgcc.1
 
 all:
 
+########################################################################
+# common flags/options/...
+
+cflags = -fno-strict-aliasing
+
 GCC_BASE := $(shell $(CC) --print-file-name=)
 cflags += -DGCC_BASE=\"$(GCC_BASE)\"
 
-- 
2.14.0


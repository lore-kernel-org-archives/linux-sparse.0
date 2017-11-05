From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 36/36] build: use a single space before assignments
Date: Sun,  5 Nov 2017 17:25:44 +0100
Message-ID: <20171105162544.72960-36-luc.vanoostenryck@gmail.com>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:46329 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbdKEQ0s (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 11:26:48 -0500
Received: by mail-wm0-f68.google.com with SMTP id r68so9538080wmr.1
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 08:26:48 -0800 (PST)
In-Reply-To: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 5ce359492..ece04bb9f 100644
--- a/Makefile
+++ b/Makefile
@@ -164,8 +164,8 @@ LIBS := libsparse.a
 OBJS := $(LIB_OBJS) $(EXTRA_OBJS) $(PROGRAMS:%=%.o)
 
 # Pretty print
-V	      = @
-Q	      = $(V:1=)
+V := @
+Q := $(V:1=)
 
 ########################################################################
 all: $(PROGRAMS)
-- 
2.14.0


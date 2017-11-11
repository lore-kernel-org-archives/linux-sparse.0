From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 36/38] build: use a single space before assignments
Date: Sat, 11 Nov 2017 15:24:35 +0100
Message-ID: <20171111142437.67359-37-luc.vanoostenryck@gmail.com>
References: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56474 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbdKKOZ5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 09:25:57 -0500
Received: by mail-wm0-f66.google.com with SMTP id z3so7589732wme.5
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 06:25:57 -0800 (PST)
In-Reply-To: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 92bf9e726..2c70d904b 100644
--- a/Makefile
+++ b/Makefile
@@ -165,8 +165,8 @@ LIBS := libsparse.a
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


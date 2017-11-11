From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 12/38] build: avoid rule-specific CFLAGS
Date: Sat, 11 Nov 2017 15:24:11 +0100
Message-ID: <20171111142437.67359-13-luc.vanoostenryck@gmail.com>
References: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56278 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbdKKOZM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 09:25:12 -0500
Received: by mail-wm0-f67.google.com with SMTP id 9so2082594wme.4
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 06:25:11 -0800 (PST)
In-Reply-To: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

Those are not evil but it's for consistency with the remaining.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 8a06b75a5..c66f730af 100644
--- a/Makefile
+++ b/Makefile
@@ -72,7 +72,7 @@ PROGRAMS += test-inspect
 INST_PROGRAMS += test-inspect
 test-inspect-objs := test-inspect.o
 test-inspect-objs += ast-model.o ast-view.o ast-inspect.o
-$(test-inspect-objs) $(test-inspect-objs:.o=.sc): CFLAGS += $(GTK_CFLAGS)
+$(foreach p,$(test-inspect-objs:.o=),$(eval $(p)-cflags := $(GTK_CFLAGS)))
 test-inspect-ldlibs := $(GTK_LIBS)
 else
 $(warning Your system does not have gtk3/gtk2, disabling test-inspect)
-- 
2.14.0


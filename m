From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 12/37] build: avoid rule-specific CFLAGS
Date: Thu,  9 Nov 2017 07:46:23 +0100
Message-ID: <20171109064648.15379-13-luc.vanoostenryck@gmail.com>
References: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:47473 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752498AbdKIGrQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 01:47:16 -0500
Received: by mail-wm0-f67.google.com with SMTP id r196so14825409wmf.2
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 22:47:16 -0800 (PST)
In-Reply-To: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Josh Triplett <josh@joshtriplett.org>, Jeff Layton <jlayton@redhat.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Those are not evil but it's for consistency with the remaining.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index fed392c8a..73fc6d554 100644
--- a/Makefile
+++ b/Makefile
@@ -72,7 +72,7 @@ PROGRAMS += test-inspect
 INST_PROGRAMS += test-inspect
 test-inspect_OBJS := test-inspect.o
 test-inspect_OBJS += ast-model.o ast-view.o ast-inspect.o
-$(test-inspect_OBJS) $(test-inspect_OBJS:.o=.sc): CFLAGS += $(GTK_CFLAGS)
+$(foreach p,$(test-inspect_OBJS:.o=),$(eval $(p)_CFLAGS := $(GTK_CFLAGS)))
 test-inspect_LDLIBS := $(GTK_LIBS)
 else
 $(warning Your system does not have gtk3/gtk2, disabling test-inspect)
-- 
2.14.0


From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 19/38] build: add note about overwritable vars
Date: Sat, 11 Nov 2017 15:24:18 +0100
Message-ID: <20171111142437.67359-20-luc.vanoostenryck@gmail.com>
References: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53237 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbdKKOZW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 09:25:22 -0500
Received: by mail-wm0-f68.google.com with SMTP id t139so7602182wmt.1
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 06:25:21 -0800 (PST)
In-Reply-To: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index ce57ed3cb..f1f210e27 100644
--- a/Makefile
+++ b/Makefile
@@ -1,5 +1,7 @@
 VERSION=0.5.1
 
+########################################################################
+# The following variables can be overwritten from the command line
 OS = linux
 
 
@@ -24,6 +26,7 @@ MAN1DIR=$(MANDIR)/man1
 #     CFLAGS += -O0 -DDEBUG -g3 -gdwarf-2
 #
 -include local.mk
+########################################################################
 
 
 PROGRAMS=test-lexing test-parsing obfuscate compile graph sparse \
-- 
2.14.0


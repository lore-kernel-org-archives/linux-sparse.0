From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 19/36] build: add note about overwritable vars
Date: Sun,  5 Nov 2017 17:25:27 +0100
Message-ID: <20171105162544.72960-19-luc.vanoostenryck@gmail.com>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51096 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbdKEQ0R (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 11:26:17 -0500
Received: by mail-wm0-f65.google.com with SMTP id s66so9447569wmf.5
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 08:26:17 -0800 (PST)
In-Reply-To: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index ea3ce89a4..f150b9eb9 100644
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


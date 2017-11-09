From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 19/37] build: add note about overwritable vars
Date: Thu,  9 Nov 2017 07:46:30 +0100
Message-ID: <20171109064648.15379-20-luc.vanoostenryck@gmail.com>
References: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51970 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752493AbdKIGr2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 01:47:28 -0500
Received: by mail-wm0-f66.google.com with SMTP id b9so15332173wmh.0
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 22:47:28 -0800 (PST)
In-Reply-To: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Josh Triplett <josh@joshtriplett.org>, Jeff Layton <jlayton@redhat.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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


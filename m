From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 04/37] build: drop -g from LDFLAGS
Date: Thu,  9 Nov 2017 07:46:15 +0100
Message-ID: <20171109064648.15379-5-luc.vanoostenryck@gmail.com>
References: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54383 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752499AbdKIGrE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 01:47:04 -0500
Received: by mail-wm0-f65.google.com with SMTP id r68so15293861wmr.3
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 22:47:03 -0800 (PST)
In-Reply-To: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Josh Triplett <josh@joshtriplett.org>, Jeff Layton <jlayton@redhat.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

From: Uwe Kleine-König <uwe@kleine-koenig.org>

-g is a compiler option that is ignored by the linker. So it should be
included in CFLAGS (it already is) but not LDFLAGS.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile b/Makefile
index 069dae6c8..39b34f901 100644
--- a/Makefile
+++ b/Makefile
@@ -14,7 +14,6 @@ OS = linux
 CC = gcc
 CFLAGS = -O2 -finline-functions -fno-strict-aliasing -g
 CFLAGS += -Wall -Wwrite-strings
-LDFLAGS += -g
 LD = gcc
 AR = ar
 PKG_CONFIG = pkg-config
-- 
2.14.0


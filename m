From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 04/36] build: drop -g from LDFLAGS
Date: Sun,  5 Nov 2017 17:25:12 +0100
Message-ID: <20171105162544.72960-4-luc.vanoostenryck@gmail.com>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:46225 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750782AbdKEQZ5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 11:25:57 -0500
Received: by mail-wm0-f66.google.com with SMTP id r68so9535849wmr.1
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 08:25:56 -0800 (PST)
In-Reply-To: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

From: Uwe Kleine-König <uwe@kleine-koenig.org>

-g is a compiler option that is ignored by the linker. So it should be
included in CFLAGS (it already is) but not LDFLAGS.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
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


From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: [PATCH 4/6] build: drop -g from LDFLAGS
Date: Wed,  4 Oct 2017 15:26:03 +0200
Message-ID: <20171004132605.24734-5-uwe@kleine-koenig.org>
References: <20171004132605.24734-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:54540 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752622AbdJDN0P (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 4 Oct 2017 09:26:15 -0400
In-Reply-To: <20171004132605.24734-1-uwe@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

-g is a compiler option that is ignored by the linker. So it should be
included in CFLAGS (it already is) but not LDFLAGS.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile b/Makefile
index 069dae6c8fdb..39b34f90107d 100644
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
2.14.2


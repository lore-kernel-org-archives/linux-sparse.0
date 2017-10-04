From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: [PATCH 1/6] build: make PREFIX overwritable from the environment
Date: Wed,  4 Oct 2017 15:26:00 +0200
Message-ID: <20171004132605.24734-2-uwe@kleine-koenig.org>
References: <20171004132605.24734-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:54537 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751997AbdJDN0N (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 4 Oct 2017 09:26:13 -0400
In-Reply-To: <20171004132605.24734-1-uwe@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This way I can just use

	env PREFIX=/usr make install

on the command line to install sparse into the system.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index d0341764158e..e011df3cc0dc 100644
--- a/Makefile
+++ b/Makefile
@@ -54,7 +54,7 @@ BASIC_CFLAGS += -Wp,-MD,$(@D)/.$(@F).d
 endif
 
 DESTDIR=
-PREFIX=$(HOME)
+PREFIX ?= $(HOME)
 BINDIR=$(PREFIX)/bin
 LIBDIR=$(PREFIX)/lib
 MANDIR=$(PREFIX)/share/man
-- 
2.14.2


From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 01/38] build: make PREFIX overwritable from the environment
Date: Sat, 11 Nov 2017 15:24:00 +0100
Message-ID: <20171111142437.67359-2-luc.vanoostenryck@gmail.com>
References: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56250 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbdKKOYw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 09:24:52 -0500
Received: by mail-wm0-f67.google.com with SMTP id 9so2081783wme.4
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 06:24:52 -0800 (PST)
In-Reply-To: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

From: Uwe Kleine-König <uwe@kleine-koenig.org>

This way I can just use

	env PREFIX=/usr make install

on the command line to install sparse into the system.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index d03417641..e011df3cc 100644
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
2.14.0


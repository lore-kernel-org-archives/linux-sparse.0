From: =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@gmail.com>
Subject: [PATCH 2/3] build: add an all-installable target that builds the targets to install.
Date: Wed, 13 Apr 2011 13:06:05 +0200
Message-ID: <1302692766-30217-2-git-send-email-flameeyes@gmail.com>
References: <1302692766-30217-1-git-send-email-flameeyes@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53566 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758435Ab1DMLJi (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 13 Apr 2011 07:09:38 -0400
Received: by wya21 with SMTP id 21so385780wya.19
        for <linux-sparse@vger.kernel.org>; Wed, 13 Apr 2011 04:09:37 -0700 (PDT)
In-Reply-To: <1302692766-30217-1-git-send-email-flameeyes@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@gmail.com>

This is useful for distributions that don't want to build content that
won't be installed.
---
 Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index e08143a..ffb513f 100644
--- a/Makefile
+++ b/Makefile
@@ -118,7 +118,9 @@ SED_PC_CMD = 's|@version@|$(VERSION)|g;		\
 
 all: $(PROGRAMS) sparse.pc
 
-install: $(INST_PROGRAMS) $(LIBS) $(LIB_H) sparse.pc
+all-installable: $(INST_PROGRAMS) $(LIBS) $(LIB_H) sparse.pc
+
+install: all-installable
 	$(Q)install -d $(DESTDIR)$(BINDIR)
 	$(Q)install -d $(DESTDIR)$(LIBDIR)
 	$(Q)install -d $(DESTDIR)$(MAN1DIR)
-- 
1.7.5.rc1


From: =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@gmail.com>
Subject: [PATCH 1/3] build: allow easy override of GCC_BASE
Date: Wed, 13 Apr 2011 13:06:04 +0200
Message-ID: <1302692766-30217-1-git-send-email-flameeyes@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42530 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758428Ab1DMLJh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 13 Apr 2011 07:09:37 -0400
Received: by wwa36 with SMTP id 36so583840wwa.1
        for <linux-sparse@vger.kernel.org>; Wed, 13 Apr 2011 04:09:36 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@gmail.com>

Sometimes gcc reports the wrong path for its own base (for instance when
ICC is present in the same system); by allowing an override of GCC_BASE in
Makefile, it's easier for packages to fix this up.
---
 Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index cc6176f..e08143a 100644
--- a/Makefile
+++ b/Makefile
@@ -21,7 +21,8 @@ HAVE_GCC_DEP:=$(shell touch .gcc-test.c && 				\
 		echo 'yes'; rm -f .gcc-test.d .gcc-test.o .gcc-test.c)
 HAVE_GTK2:=$(shell pkg-config --exists gtk+-2.0 2>/dev/null && echo 'yes')
 
-CFLAGS += -DGCC_BASE=\"$(shell $(CC) --print-file-name=)\"
+GCC_BASE = $(shell $(CC) --print-file-name=)
+CFLAGS += -DGCC_BASE=\"$(GCC_BASE)\"
 
 ifeq ($(HAVE_GCC_DEP),yes)
 CFLAGS += -Wp,-MD,$(@D)/.$(@F).d
-- 
1.7.5.rc1


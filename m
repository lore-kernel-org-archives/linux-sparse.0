From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] Makefile: warn user when libxml and/or libgtk2 are not available
Date: Thu, 3 Mar 2011 09:57:58 +0100
Message-ID: <201103030957.59003.f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50703 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069Ab1CCI4n (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 3 Mar 2011 03:56:43 -0500
Received: by wyg36 with SMTP id 36so827848wyg.19
        for <linux-sparse@vger.kernel.org>; Thu, 03 Mar 2011 00:56:42 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

Since sparse's c2xml is not always packaged by modern distributions, it can be
built as a host package in build systems, finding out why c2xml was not
compiled turned out to be easier if a warning was emitted, add two for libxml
and libgtk2 presence/absence.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
diff --git a/Makefile b/Makefile
index 74905df..e9ae26f 100644
--- a/Makefile
+++ b/Makefile
@@ -45,6 +45,8 @@ ifeq ($(HAVE_LIBXML),yes)
 PROGRAMS+=c2xml
 INST_PROGRAMS+=c2xml
 c2xml_EXTRA_OBJS = `pkg-config --libs libxml-2.0`
+else
+$(info Your system does not have libxml, disabling c2xml)
 endif

 ifeq ($(HAVE_GTK2),yes)
@@ -55,6 +57,8 @@ INST_PROGRAMS += test-inspect
 test-inspect_EXTRA_DEPS := ast-model.o ast-view.o ast-inspect.o
 test-inspect.o $(test-inspect_EXTRA_DEPS): CFLAGS += $(GTK2_CFLAGS)
 test-inspect_EXTRA_OBJS := $(GTK2_LIBS)
+else
+$(info Your system does not have libgtk2, disabling test-inspect)
 endif

 LIB_H=    token.h parse.h lib.h symbol.h scope.h expression.h target.h \
--

From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH] build: assign extra flags to ALL_CFLAGS instead of CFLAGS
Date: Wed, 18 Oct 2017 11:07:27 -0400
Message-ID: <20171018150727.26821-1-jlayton@kernel.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751659AbdJRPHa (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 18 Oct 2017 11:07:30 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5831D21879
        for <linux-sparse@vger.kernel.org>; Wed, 18 Oct 2017 15:07:29 +0000 (UTC)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

The fedora packaging tools want to override $CFLAGS when building
sparse, but that fails on a couple of targets.

There are a couple of build targets in the makefile that want to add
options to $CFLAGS. When we do a build though, we pass $ALL_CFLAGS
to the compiler, and that ends up not getting options passed in
via $CFLAGS on the command line.

Fix the two specific build targets to add the options to $ALL_CFLAGS
instead of $CFLAGS.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index d0341764158e..b24680b885fe 100644
--- a/Makefile
+++ b/Makefile
@@ -83,7 +83,7 @@ PROGRAMS += test-inspect
 INST_PROGRAMS += test-inspect
 test-inspect_EXTRA_DEPS := ast-model.o ast-view.o ast-inspect.o
 test-inspect_OBJS := test-inspect.o $(test-inspect_EXTRA_DEPS)
-$(test-inspect_OBJS) $(test-inspect_OBJS:.o=.sc): CFLAGS += $(GTK_CFLAGS)
+$(test-inspect_OBJS) $(test-inspect_OBJS:.o=.sc): ALL_CFLAGS += $(GTK_CFLAGS)
 test-inspect_EXTRA_OBJS := $(GTK_LIBS)
 else
 $(warning Your system does not have gtk3/gtk2, disabling test-inspect)
@@ -208,7 +208,7 @@ ifneq ($(DEP_FILES),)
 include $(DEP_FILES)
 endif
 
-c2xml.o c2xml.sc: CFLAGS += $(LIBXML_CFLAGS)
+c2xml.o c2xml.sc: ALL_CFLAGS += $(LIBXML_CFLAGS)
 
 pre-process.sc: CHECKER_FLAGS += -Wno-vla
 
-- 
2.13.6


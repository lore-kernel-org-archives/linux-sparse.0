From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] Makefile: pass -Wno-vla to sparse while checking
 pre-process.c
Date: Mon, 31 Jul 2017 00:27:42 +0100
Message-ID: <c318f85f-43e5-e902-3032-89eeddcb4ffa@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout05.plus.net ([84.93.230.250]:57838 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751609AbdG3X1p (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 30 Jul 2017 19:27:45 -0400
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>


Introduce a $(CHECKER_FLAGS) variable to allow adding flags, using
target specific variable assignments, to specific $(CHECKER) command
invocations. In particular, in a new pre-process.cs target, include
'-Wno-vla' in the flags while checking pre-process.c.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Chris,

This is what I had in mind for the selfcheck of pre-process.c.
With this patch, selfcheck is clean for me on Linux, but not
on cygwin (I will look at fixing that later).

Thanks!

ATB,
Ramsay Jones

 Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 64146db..c20ea2c 100644
--- a/Makefile
+++ b/Makefile
@@ -19,6 +19,7 @@ LD = gcc
 AR = ar
 PKG_CONFIG = pkg-config
 CHECKER = ./cgcc -no-compile
+CHECKER_FLAGS =
 
 ALL_CFLAGS = $(CFLAGS) $(BASIC_CFLAGS)
 #
@@ -198,11 +199,13 @@ endif
 
 c2xml.o c2xml.sc: CFLAGS += $(LIBXML_CFLAGS)
 
+pre-process.sc: CHECKER_FLAGS += -Wno-vla
+
 %.o: %.c $(LIB_H)
 	$(QUIET_CC)$(CC) -o $@ -c $(ALL_CFLAGS) $<
 
 %.sc: %.c sparse
-	$(QUIET_CHECK) $(CHECKER) -c $(ALL_CFLAGS) $<
+	$(QUIET_CHECK) $(CHECKER) $(CHECKER_FLAGS) -c $(ALL_CFLAGS) $<
 
 ALL_OBJS :=  $(LIB_OBJS) $(foreach p,$(PROGRAMS),$(p).o $($(p)_EXTRA_DEPS))
 selfcheck: $(ALL_OBJS:.o=.sc)
-- 
2.13.0

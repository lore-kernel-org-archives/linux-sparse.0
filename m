From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 4/3] inlined call bugfix & test
Date: Fri, 11 Apr 2008 13:07:47 +0200
Message-ID: <1207912067.13354.54.camel@johannes.berg>
References: <20080410132519.049821000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from crystal.sipsolutions.net ([195.210.38.204]:37338 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbYDKMIT (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 11 Apr 2008 08:08:19 -0400
In-Reply-To: <20080410132519.049821000@sipsolutions.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org

This patch fixes an oversight in my other patches, inlined
calls weren't checked for context properly. Also adds a test
case for this.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
I'll roll this into the other patches if wanted.

 sparse.c                   |    1 +
 validation/context-named.c |   12 ++++++++++++
 2 files changed, 13 insertions(+)

--- sparse.orig/sparse.c	2008-04-11 12:42:49.000000000 +0200
+++ sparse/sparse.c	2008-04-11 12:43:44.000000000 +0200
@@ -137,6 +137,7 @@ static int check_bb_context(struct entry
 		if (!insn->bb)
 			continue;
 		switch (insn->opcode) {
+		case OP_INLINED_CALL:
 		case OP_CALL:
 			if (!insn->func || !insn->func->sym || insn->func->type != PSEUDO_SYM)
 				break;
--- sparse.orig/validation/context-named.c	2008-04-11 12:42:49.000000000 +0200
+++ sparse/validation/context-named.c	2008-04-11 12:46:36.000000000 +0200
@@ -465,6 +465,17 @@ static void warn_exact_fn2(void)
     r2();
 }
 
+static inline void need_lock3(void) __attribute__((context(TEST,1,1)))
+{
+}
+
+static void warn_fn3(void)
+{
+    a2();
+    need_lock3();
+    r2();
+}
+
 #define __acquire(x)	__context__(x,1)
 #define __release(x)	__context__(x,-1)
 
@@ -513,5 +524,6 @@ context-named.c:434:14: warning: context
 context-named.c:441:15: warning: context problem in 'warn_fn2' - function 'need_lock2' expected different context
 context-named.c:456:20: warning: context problem in 'warn_exact_fn1' - function 'need_lock_exact' expected different context
 context-named.c:464:20: warning: context problem in 'warn_exact_fn2' - function 'need_lock_exact' expected different context
+context-named.c:475:15: warning: context problem in 'warn_fn3' - function 'need_lock3' expected different context
  * check-error-end
  */



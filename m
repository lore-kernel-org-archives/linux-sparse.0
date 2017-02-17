From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC] CSE: relax type checking in hashing/compare
Date: Fri, 17 Feb 2017 01:06:07 +0100
Message-ID: <20170217000608.6433-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35654 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751801AbdBQAGQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Feb 2017 19:06:16 -0500
Received: by mail-wm0-f67.google.com with SMTP id u63so42102wmu.2
        for <linux-sparse@vger.kernel.org>; Thu, 16 Feb 2017 16:06:15 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently in a function like here below the comparision is not
optimized away. This is because CSE doesn't recognize 'a = &g'
and 'b = &g' as being equivalent expressions.
	static int foo(void) {
		extern int g;
		void *a = &g;
		void *b = &g;
		return a == b;
	}

The problem come in fact from the implicit cast, more precisely, 
because the two '&g' generate their own symbol and thus have
distinct types.

I made a patch (see the second one in this non-serie) so that
cast from equivalent types hash identically. It worked well
but after a while I concluded that it was not really needed.
Indeed, in the context of CSE, to consider two instructions as
equivalent, the first thing that need to be equal is their source
operands. Isn't it already the case that if we use the same pseudo
in two instructions, the type of these pseudo in each instructions
must already be, if not identical, at least 'sufficently equivalent'?

I'm missing something?

If not, then the following simple patch should be correct.

Note: this patch give almost the same results as my original,
complex version. Both can eliminate quite a few casts (the
output of test-linearize on a subset of GCC's testsuite gives
a good 33K diff), both gives correct results for the case I've
checked and when using sparse on a kernel's allyesconfig run,
both give exactly the same warnings with ot without the patch).

Luc Van Oostenryck

---
 cse.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/cse.c b/cse.c
index 89812afae..d7f5de302 100644
--- a/cse.c
+++ b/cse.c
@@ -91,13 +91,6 @@ static void clean_up_one_instruction(struct basic_block *bb, struct instruction
 	case OP_CAST:
 	case OP_SCAST:
 	case OP_PTRCAST:
-		/*
-		 * This is crap! Many "orig_types" are the
-		 * same as far as casts go, we should generate
-		 * some kind of "type hash" that is identical
-		 * for identical casts
-		 */
-		hash += hashval(insn->orig_type);
 		hash += hashval(insn->src);
 		break;
 
@@ -235,11 +228,6 @@ static int insn_compare(const void *_i1, const void *_i2)
 	case OP_CAST:
 	case OP_SCAST:
 	case OP_PTRCAST:
-		/*
-		 * This is crap! See the comments on hashing.
-		 */
-		if (i1->orig_type != i2->orig_type)
-			return i1->orig_type < i2->orig_type ? -1 : 1;
 		if (i1->src != i2->src)
 			return i1->src < i2->src ? -1 : 1;
 		break;

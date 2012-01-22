From: =?ISO-8859-1?Q?Jan_Pokorn=FD?= <pokorny_jan@seznam.cz>
Subject: [PATCH] evaluate: reject post-ops on void*
Date: Mon, 23 Jan 2012 00:31:21 +0100
Message-ID: <4F1C9C49.2050707@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fep21.mx.upcmail.net ([62.179.121.41]:41302 "EHLO
	fep21.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376Ab2AVXex (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 22 Jan 2012 18:34:53 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: Christopher Li <sparse@chrisli.org>

Following example haven't been linearized correctly:

	static void *inc_ptr(void *a) {
		return ++a;
	}

test-linearize:

	<entry-point>
	add.32      %r2 <- %arg1, $-1
	ret.32      %r2

Apparently, something went wrong with -1 value to be added to the original
pointer.  When void* substituted for int*, the result is as expected
(considering 32b int):

	<entry-point>
	add.32      %r2 <- %arg1, $4
	ret.32      %r2

The proposed patch turns post-ops on void* operand into an error
(taking the same route as with function operand).

When running check with C=2 on my old linux-3.0.6 configuration,
this detected a few occurencies:

	drivers/scsi/scsi_proc.c:405:31: error: bad argument type for ++/--
	drivers/scsi/scsi_proc.c:413:23: error: bad argument type for ++/--
	net/bluetooth/hci_core.c:1545:29: error: bad argument type for ++/--
	net/bluetooth/l2cap_core.c:1825:37: error: bad argument type for ++/--
	net/bluetooth/bnep/core.c:239:13: error: bad argument type for ++/--
	lib/sort.c:25:27: error: bad argument type for ++/--
	lib/sort.c:26:27: error: bad argument type for ++/--
	lib/check_signature.c:21:24: error: bad argument type for ++/--

All of them seems trivially fixable.

Alternatively, I can turn it to emit an warning only (should be
configurable/default?).  To be noted that GCC will only emit an warning,
and only if -pedantic or -Wpointer-arith specified, but I consider
it rather a convenient exception.

When this gets clear, I'll add also the respective test-case.

Signed-off-by: Jan Pokorny <pokorny_jan@seznam.cz>
---
 evaluate.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index bebe968..b6d706b 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1711,7 +1711,8 @@ static struct symbol *evaluate_postop(struct expression *expr)
 		multiply = 1;
 	} else if (class == TYPE_PTR) {
 		struct symbol *target = examine_pointer_target(ctype);
-		if (!is_function(target))
+		/* beside function, reject also void* (due to sizeof(void)) */
+		if (target != &void_ctype && !is_function(target))
 			multiply = bits_to_bytes(target->bit_size);
 	}
 
-- 
1.7.3.4


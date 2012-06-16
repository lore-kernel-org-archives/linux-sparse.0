From: Xi Wang <xi.wang@gmail.com>
Subject: [RFC][PATCH] fix casting constant to _Bool
Date: Sat, 16 Jun 2012 02:55:20 -0400
Message-ID: <1339829720-2069-1-git-send-email-xi.wang@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:59015 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754960Ab2FPGzd (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 16 Jun 2012 02:55:33 -0400
Received: by qcro28 with SMTP id o28so2078760qcr.19
        for <linux-sparse@vger.kernel.org>; Fri, 15 Jun 2012 23:55:32 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Pekka Enberg <penberg@kernel.org>, Xi Wang <xi.wang@gmail.com>

Casting to _Bool requires a zero test rather than truncation.

Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
A simple example is:

  _Bool x = 0x200;

x should have been true rather than false.

BTW, this patch also disables the warning "cast truncates bits from
constant value".  Does that sound good?

A more serious problem is something like:

  _Bool foo(int x) { return x; }

sparse emits:

  scast.1     %r2 <- (32) %arg1

which makes sparse-llvm generate:

  %R2 = trunc i32 %0 to i1

My experimental backend "splay" has to treat _Bool specifically to
generate:

  %0 = icmp ne i32 %x, 0

Should we leave the conversion job to backends, or should we just fix
the sparse IR (e.g., emitting setne rather than scast for casts to _Bool)?
---
 expand.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/expand.c b/expand.c
index 63a9075..ee818a4 100644
--- a/expand.c
+++ b/expand.c
@@ -92,6 +92,12 @@ void cast_value(struct expression *expr, struct symbol *newtype,
 	value = get_longlong(old);
 
 Int:
+	// _Bool requires a zero test rather than truncation.
+	if (is_bool_type(newtype)) {
+		expr->value = value ? 1 : 0;
+		return;
+	}
+
 	// Truncate it to the new size
 	signmask = 1ULL << (new_size-1);
 	mask = signmask | (signmask-1);
-- 
1.7.9.5


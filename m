From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/3] add support for -Wmemcpy-max-count
Date: Thu,  1 Jun 2017 22:27:23 +0200
Message-ID: <20170601202724.77597-3-luc.vanoostenryck@gmail.com>
References: <84e547c2-8a5b-225c-1363-361e091821f4@ramsayjones.plus.com>
 <20170601202724.77597-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36284 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbdFAU1i (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 1 Jun 2017 16:27:38 -0400
Received: by mail-wm0-f66.google.com with SMTP id k15so14124074wmh.3
        for <linux-sparse@vger.kernel.org>; Thu, 01 Jun 2017 13:27:37 -0700 (PDT)
In-Reply-To: <20170601202724.77597-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Li <sparse@chrisli.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Junio C Hamano <gitster@pobox.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

sparse will warn if memcpy() (or memset(), copy_from_user(),
copy_to_user()) is called with a very large static byte-count.

But this warning is given unconditionaly while there are projects
where this warning may not be not desired.

Change this by making this warning conditional on a new warning
flag: -Wmemcpy-max-count=COUNT.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c    | 2 ++
 lib.h    | 1 +
 sparse.1 | 8 ++++++++
 sparse.c | 3 ++-
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/lib.c b/lib.c
index e1e6a1cbf..90fd2b494 100644
--- a/lib.c
+++ b/lib.c
@@ -229,6 +229,7 @@ int Wdo_while = 0;
 int Winit_cstring = 0;
 int Wenum_mismatch = 1;
 int Wsparse_error = 0;
+int Wmemcpy_max_count = 1;
 int Wnon_pointer_null = 1;
 int Wold_initializer = 1;
 int Wone_bit_signed_bitfield = 1;
@@ -506,6 +507,7 @@ static const struct warning {
 	{ "enum-mismatch", &Wenum_mismatch },
 	{ "sparse-error", &Wsparse_error },
 	{ "init-cstring", &Winit_cstring },
+	{ "memcpy-max-count", &Wmemcpy_max_count },
 	{ "non-pointer-null", &Wnon_pointer_null },
 	{ "old-initializer", &Wold_initializer },
 	{ "one-bit-signed-bitfield", &Wone_bit_signed_bitfield },
diff --git a/lib.h b/lib.h
index 2c8529f93..8090fe247 100644
--- a/lib.h
+++ b/lib.h
@@ -116,6 +116,7 @@ extern int Wdo_while;
 extern int Wenum_mismatch;
 extern int Wsparse_error;
 extern int Winit_cstring;
+extern int Wmemcpy_max_count;
 extern int Wnon_pointer_null;
 extern int Wold_initializer;
 extern int Wone_bit_signed_bitfield;
diff --git a/sparse.1 b/sparse.1
index c924b3a59..efbd78d01 100644
--- a/sparse.1
+++ b/sparse.1
@@ -210,6 +210,14 @@ trouble.
 Sparse does not issue these warnings by default.
 .
 .TP
+.B \-Wmemcpy\-max\-count
+Warn about call of \fBmemset()\fR, \fBmemset()\fR, \fBcopy_from_user()\fR, or
+\fBcopy_to_user()\fR with a large compile-time byte count.
+
+Sparse issues these warnings by default. To turn them off, use
+\fB\-Wno\-memcpy\-max\-count\fR.
+.
+.TP
 .B \-Wnon\-pointer\-null
 Warn about the use of 0 as a NULL pointer.
 
diff --git a/sparse.c b/sparse.c
index 1cb90e20d..aa5979f1a 100644
--- a/sparse.c
+++ b/sparse.c
@@ -153,7 +153,8 @@ static void check_byte_count(struct instruction *insn, pseudo_t count)
 		return;
 	if (count->type == PSEUDO_VAL) {
 		unsigned long long val = count->value;
-		if (val > 100000ULL)
+		if (Wmemcpy_max_count && val > 100000ULL)
+
 			warning(insn->pos, "%s with byte count of %llu",
 				show_ident(insn->func->sym->ident), val);
 		return;
-- 
2.13.0


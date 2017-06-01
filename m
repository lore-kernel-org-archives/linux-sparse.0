From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] add support for -fmemcpy-max-count
Date: Thu,  1 Jun 2017 22:27:24 +0200
Message-ID: <20170601202724.77597-4-luc.vanoostenryck@gmail.com>
References: <84e547c2-8a5b-225c-1363-361e091821f4@ramsayjones.plus.com>
 <20170601202724.77597-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33779 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbdFAU1j (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 1 Jun 2017 16:27:39 -0400
Received: by mail-wm0-f68.google.com with SMTP id b84so14127773wmh.0
        for <linux-sparse@vger.kernel.org>; Thu, 01 Jun 2017 13:27:38 -0700 (PDT)
In-Reply-To: <20170601202724.77597-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Li <sparse@chrisli.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Junio C Hamano <gitster@pobox.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

By default, sparse will warn if memcpy() (or memset(),
copy_from_user(), copy_to_user()) is called with a very large
static byte-count.

But the limit is currently fixed at 100000, which may be fine
for some uses but not for others. For example, this value is
too low for sparse to be used on the git tree where, for example,
some array used to sort the index is cleared with memset().

Change this by making the limit configurable via a new flag:
-fmemcpy-max-count.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c    | 16 ++++++++++++++++
 lib.h    |  1 +
 sparse.1 | 10 ++++++++++
 sparse.c |  3 +--
 4 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/lib.c b/lib.c
index 90fd2b494..1378cc243 100644
--- a/lib.c
+++ b/lib.c
@@ -256,6 +256,7 @@ int dbg_dead = 0;
 
 int fmem_report = 0;
 int fdump_linearize;
+unsigned long fmemcpy_max_count = 100000;
 
 int preprocess_only;
 
@@ -670,6 +671,19 @@ static char **handle_switch_O(char *arg, char **next)
 	return next;
 }
 
+static char **handle_switch_fmemcpy_max_count(char *arg, char **next)
+{
+	unsigned long val;
+	char *end;
+
+	val = strtoul(arg, &end, 0);
+	if (*end != '\0' || end == arg)
+		die("error: missing argument to \"-fmemcpy-max-count=\"");
+
+	fmemcpy_max_count = val;
+	return next;
+}
+
 static char **handle_switch_ftabstop(char *arg, char **next)
 {
 	char *end;
@@ -713,6 +727,8 @@ static char **handle_switch_f(char *arg, char **next)
 		return handle_switch_ftabstop(arg+8, next);
 	if (!strncmp(arg, "dump-", 5))
 		return handle_switch_fdump(arg+5, next);
+	if (!strncmp(arg, "memcpy-max-count=", 17))
+		return handle_switch_fmemcpy_max_count(arg+17, next);
 
 	/* handle switches w/ arguments above, boolean and only boolean below */
 	if (handle_simple_switch(arg, "mem-report", &fmem_report))
diff --git a/lib.h b/lib.h
index 8090fe247..b7cb451e0 100644
--- a/lib.h
+++ b/lib.h
@@ -143,6 +143,7 @@ extern int dbg_dead;
 
 extern int fmem_report;
 extern int fdump_linearize;
+extern unsigned long fmemcpy_max_count;
 
 extern int arch_m64;
 
diff --git a/sparse.1 b/sparse.1
index efbd78d01..932ac82ef 100644
--- a/sparse.1
+++ b/sparse.1
@@ -216,6 +216,9 @@ Warn about call of \fBmemset()\fR, \fBmemset()\fR, \fBcopy_from_user()\fR, or
 
 Sparse issues these warnings by default. To turn them off, use
 \fB\-Wno\-memcpy\-max\-count\fR.
+
+The limit can be changed with \fB\-fmemcpy\-max\-count=COUNT\fR,
+the default being \fB100000\fR.
 .
 .TP
 .B \-Wnon\-pointer\-null
@@ -364,6 +367,13 @@ Report some statistics about memory allocation used by the tool.
 .
 .SH OTHER OPTIONS
 .TP
+.B \-fmemcpy-limit=COUNT
+By default, sparse will warn if \fBmemcpy()\fR (or \fBmemset()\fR,
+\fBcopy_from_user()\fR, copy_to_user()\fR) is called with a very large
+(known at compile-time) byte-count. COUNT is the value under which
+no such warning will be given. The default limit is 100000.
+.
+.TP
 .B \-ftabstop=WIDTH
 Set the distance between tab stops.  This helps sparse report correct
 column numbers in warnings or errors.  If the value is less than 1 or
diff --git a/sparse.c b/sparse.c
index aa5979f1a..bceacd94e 100644
--- a/sparse.c
+++ b/sparse.c
@@ -153,8 +153,7 @@ static void check_byte_count(struct instruction *insn, pseudo_t count)
 		return;
 	if (count->type == PSEUDO_VAL) {
 		unsigned long long val = count->value;
-		if (Wmemcpy_max_count && val > 100000ULL)

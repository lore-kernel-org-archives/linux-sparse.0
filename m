From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 1/6] add support for a new flag: -fdump-linearize[=only]
Date: Sat,  8 Apr 2017 23:18:56 +0200
Message-ID: <20170408211901.40507-2-luc.vanoostenryck@gmail.com>
References: <20170408211901.40507-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36684 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752002AbdDHVTO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 8 Apr 2017 17:19:14 -0400
Received: by mail-wm0-f68.google.com with SMTP id q125so3594246wmd.3
        for <linux-sparse@vger.kernel.org>; Sat, 08 Apr 2017 14:19:13 -0700 (PDT)
In-Reply-To: <20170408211901.40507-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The effect of this flag is to dump the IR just after the
linearization, before any simplification, and to stop
further processing if '=only' is given as argument.

The motivation of this flag is of course for debugging,
to be able to inspect the raw result of the linearization,
undisturbed by an simplification.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c       | 23 +++++++++++++++++++++++
 lib.h       |  2 ++
 linearize.c |  6 ++++++
 sparse.1    |  7 +++++++
 4 files changed, 38 insertions(+)

diff --git a/lib.c b/lib.c
index 272d2c88a..ca8ff2d17 100644
--- a/lib.c
+++ b/lib.c
@@ -250,6 +250,8 @@ int Wvla = 1;
 int dbg_entry = 0;
 int dbg_dead = 0;
 
+int fdump_linearize;
+
 int preprocess_only;
 
 static enum { STANDARD_C89,
@@ -645,12 +647,33 @@ static char **handle_switch_ftabstop(char *arg, char **next)
 	return next;
 }
 
+static char **handle_switch_fdump(char *arg, char **next)
+{
+	if (!strncmp(arg, "linearize", 9)) {
+		arg += 9;
+		if (*arg == '\0')
+			fdump_linearize = 1;
+		else if (!strcmp(arg, "=only"))
+			fdump_linearize = 2;
+		else
+			goto err;
+	}
+
+	/* ignore others flags */
+	return next;
+
+err:
+	die("error: unknown flag \"-fdump-%s\"", arg);
+}
+
 static char **handle_switch_f(char *arg, char **next)
 {
 	arg++;
 
 	if (!strncmp(arg, "tabstop=", 8))
 		return handle_switch_ftabstop(arg+8, next);
+	if (!strncmp(arg, "dump-", 5))
+		return handle_switch_fdump(arg+5, next);
 
 	/* handle switches w/ arguments above, boolean and only boolean below */
 
diff --git a/lib.h b/lib.h
index 134e56040..fb612d154 100644
--- a/lib.h
+++ b/lib.h
@@ -136,6 +136,8 @@ extern int Wvla;
 extern int dbg_entry;
 extern int dbg_dead;
 
+extern int fdump_linearize;
+
 extern int arch_m64;
 
 extern void declare_builtin_functions(void);
diff --git a/linearize.c b/linearize.c
index 2f850fb7e..61c804333 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2171,6 +2171,12 @@ static struct entrypoint *linearize_fn(struct symbol *sym, struct symbol *base_t
 		add_one_insn(ep, insn);
 	}
 
+	if (fdump_linearize) {
+		if (fdump_linearize == 2)
+			return ep;
+		show_entry(ep);
+	}
+
 	/*
 	 * Do trivial flow simplification - branches to
 	 * branches, kill dead basicblocks etc
diff --git a/sparse.1 b/sparse.1
index 85d6e646b..525d3ded5 100644
--- a/sparse.1
+++ b/sparse.1
@@ -344,6 +344,13 @@ Look for system headers in the multiarch subdirectory \fIdir\fR.
 The \fIdir\fR name would normally take the form of the target's
 normalized GNU triplet. (e.g. i386-linux-gnu).
 .
+.SH DEBUG OPTIONS
+.TP
+.B \-fdump-linearize[=only]
+Dump the IR code of a function directly after its linearization,
+before any simplifications is made. If the argument \fB=only\fR is
+also given no further processing is done on the function.
+.
 .SH OTHER OPTIONS
 .TP
 .B \-ftabstop=WIDTH
-- 
2.12.0


From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 4] Disable liveness "dead" instruction by default.
Date: Fri, 9 Feb 2007 16:18:10 -0800
Message-ID: <20070210001810.GC20644@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sccrmhc15.comcast.net ([204.127.200.85]:59257 "EHLO
	sccrmhc15.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423378AbXBJAqq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 9 Feb 2007 19:46:46 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@freedesktop.org>

The liveness instruction take up about 10% of the bytecode bloat file.
It is not very useful, it is duplicate information can be obtain
from the def/user chain.

This change disable the liveness instruction by default.
The caller can track_pseudo_death() if needed.

Signed-Off-By: Christopher Li <sparse@chrisli.org>

Index: sparse/lib.c
===================================================================
--- sparse.orig/lib.c	2007-02-02 16:03:32.000000000 -0800
+++ sparse/lib.c	2007-02-02 16:06:25.000000000 -0800
@@ -191,7 +191,8 @@ int Wenum_mismatch = 1;
 int Wdo_while = 1;
 int Wuninitialized = 1;
 
-int dbg_entry;
+int dbg_entry = 0;
+int dbg_dead = 0;
 
 int preprocess_only;
 char *include;
@@ -391,6 +392,7 @@ static char **handle_switch_W(char *arg,
 
 static struct warning debugs[] = {
 	{ "entry", &dbg_entry},
+	{ "dead", &dbg_dead},
 };
 
 
Index: sparse/example.c
===================================================================
--- sparse.orig/example.c	2007-02-02 16:00:51.000000000 -0800
+++ sparse/example.c	2007-02-02 16:06:02.000000000 -0800
@@ -1946,6 +1946,7 @@ int main(int argc, char **argv)
 	char *file;
 
 	compile(sparse_initialize(argc, argv, &filelist));
+	dbg_dead = 1;
 	FOR_EACH_PTR_NOTAG(filelist, file) {
 		compile(sparse(file));
 	} END_FOR_EACH_PTR_NOTAG(file);
Index: sparse/lib.h
===================================================================
--- sparse.orig/lib.h	2007-02-02 16:04:07.000000000 -0800
+++ sparse/lib.h	2007-02-02 16:04:46.000000000 -0800
@@ -98,6 +98,7 @@ extern int Wdo_while;
 extern int Wuninitialized;
 
 extern int dbg_entry;
+extern int dbg_dead;
 
 extern void declare_builtin_functions(void);
 extern void create_builtin_stream(void);
Index: sparse/linearize.c
===================================================================
--- sparse.orig/linearize.c	2007-02-02 16:00:51.000000000 -0800
+++ sparse/linearize.c	2007-02-02 16:05:15.000000000 -0800
@@ -2134,7 +2134,8 @@ repeat:
 	}
 
 	/* Finally, add deathnotes to pseudos now that we have them */
-	track_pseudo_death(ep);
+	if (dbg_dead)
+		track_pseudo_death(ep);
 
 	return ep;
 }

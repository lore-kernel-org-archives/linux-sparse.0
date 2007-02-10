From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 2] Fix core dump on anonymous symbol.
Date: Fri, 9 Feb 2007 16:15:40 -0800
Message-ID: <20070210001540.GA20644@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from alnrmhc14.comcast.net ([204.127.225.94]:61824 "EHLO
	alnrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946808AbXBJAoe (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 9 Feb 2007 19:44:34 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@freedesktop.org>


Using the following can generate anonymous symbol without
initializer expression.

	return (struct foo) {};

It would be nice if sparse does not crash on it.

Signed-Off-By: Christopher Li <sparse@chrisli.org>

Index: sparse/linearize.c
===================================================================
--- sparse.orig/linearize.c	2007-01-30 19:47:10.000000000 -0800
+++ sparse/linearize.c	2007-01-30 19:47:54.000000000 -0800
@@ -116,14 +116,16 @@ const char *show_pseudo(pseudo_t pseudo)
 		}
 		expr = sym->initializer;
 		snprintf(buf, 64, "<anon symbol:%p>", sym);
-		switch (expr->type) {
-		case EXPR_VALUE:
-			snprintf(buf, 64, "<symbol value: %lld>", expr->value);
-			break;
-		case EXPR_STRING:
-			return show_string(expr->string);
-		default:
-			break;
+		if (expr) {
+			switch (expr->type) {
+			case EXPR_VALUE:
+				snprintf(buf, 64, "<symbol value: %lld>", expr->value);
+				break;
+			case EXPR_STRING:
+				return show_string(expr->string);
+			default:
+				break;
+			}
 		}
 		break;
 	}

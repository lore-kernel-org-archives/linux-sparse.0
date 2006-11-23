From: Christopher Li <sparse@chrisli.org>
Subject: [TRIVIAL][PATCH] trivial fix for seg fault.
Date: Wed, 22 Nov 2006 23:45:53 -0800
Message-ID: <20061123074553.GA9322@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sccrmhc14.comcast.net ([204.127.200.84]:62099 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S933071AbWKWHzz (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 23 Nov 2006 02:55:55 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org

Trivial fix for some seg fault.

Signed-Off-By: Christopher Li <sparse@chrisli.org>

Index: sparse/token.h
===================================================================
--- sparse.orig/token.h	2006-11-22 23:34:35.000000000 -0800
+++ sparse/token.h	2006-11-22 23:36:28.000000000 -0800
@@ -94,7 +94,7 @@
 	"||", "|=",		\
 	"^=", "##",		\
 	"<<", ">>", "..",	\
-	"<<=", ">>=", "..."	\
+	"<<=", ">>=", "...",	\
 	"",			\
 	"<", ">", "<=", ">="	\
 }

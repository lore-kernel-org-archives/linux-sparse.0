From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH] Fix warning on self check.
Date: Wed, 22 Nov 2006 23:47:43 -0800
Message-ID: <20061123074743.GB9322@chrisli.org>
References: <20061114100026.1f00f29b@lucky.kitzblitz> <456332E3.6020107@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sccrmhc13.comcast.net ([63.240.77.83]:25593 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S933043AbWKWH5o (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 23 Nov 2006 02:57:44 -0500
Content-Disposition: inline
In-Reply-To: <456332E3.6020107@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org

Fix warning on self check

Sparse complain about the using do while without
compound statment in pre-process.c. This trivial patch
fixes that.

Signed-Off-By: Christopher Li <sparse@chrisli.org>

Index: sparse/pre-process.c
===================================================================
--- sparse.orig/pre-process.c	2006-11-22 04:05:10.000000000 -0800
+++ sparse/pre-process.c	2006-11-22 23:44:34.000000000 -0800
@@ -43,20 +43,24 @@
 static const char **angle_includepath = includepath + 1;
 static const char **sys_includepath   = includepath + 1;
 
-#define dirty_stream(stream)			\
-	do if (!stream->dirty) {		\
-		stream->dirty = 1;		\
-		if (!stream->ifndef)		\
-			stream->protect = NULL;	\
+#define dirty_stream(stream)				\
+	do {						\
+		if (!stream->dirty) {			\
+			stream->dirty = 1;		\
+			if (!stream->ifndef)		\
+				stream->protect = NULL;	\
+		}					\
 	} while(0)
 
-#define end_group(stream)				\
-	do if (stream->ifndef == stream->top_if) {	\
-		stream->ifndef = NULL;			\
-		if (!stream->dirty)			\
-			stream->protect = NULL;		\
-		else if (stream->protect)		\
-			stream->dirty = 0;		\
+#define end_group(stream)					\
+	do {							\
+		if (stream->ifndef == stream->top_if) {		\
+			stream->ifndef = NULL;			\
+			if (!stream->dirty)			\
+				stream->protect = NULL;		\
+			else if (stream->protect)		\
+				stream->dirty = 0;		\
+		}						\
 	} while(0)
 
 #define nesting_error(stream)		\

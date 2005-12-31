From: Alecs King <alecsk@gmail.com>
Subject: [RFC] [PATCH] minor cleanup of type-checking for ptrlist.h
Date: Sat, 31 Dec 2005 15:20:40 +0800
Message-ID: <20051231072040.GA1638@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.196]:24120 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751313AbVLaHOO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 31 Dec 2005 02:14:14 -0500
Received: by zproxy.gmail.com with SMTP id 13so2191883nzn
        for <linux-sparse@vger.kernel.org>; Fri, 30 Dec 2005 23:14:14 -0800 (PST)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse <linux-sparse@vger.kernel.org>

DECLARE_PTR_LIST and friends are for 'Silly type-safety check'.  The
member (type *list[1]) of strust listname is never directly
dereferenced or used except for CHECK_TYPE things.  So why was it made
an array of pointer instead of simply a pointer?  IMHO, it gives no
benefits but complicates things a bit.  Or am i missing something?

This patch just change the array of pointer to a pointer.

Signed-off-by: Alecs King <alecsk@gmail.com>


diff --git a/dissect.c b/dissect.c
index 7a13ffa..be809f1 100644
--- a/dissect.c
+++ b/dissect.c
@@ -14,7 +14,7 @@
 
 #define	DO_LIST(l__, p__, expr__)		\
 	do {					\
-		typeof(l__->list[0]) p__;	\
+		typeof(l__->list) p__;	\
 		FOR_EACH_PTR(l__, p__)		\
 			expr__;			\
 		END_FOR_EACH_PTR(p__);		\
@@ -22,8 +22,8 @@
 
 #define	DO_2_LIST(l1__,l2__, p1__,p2__, expr__)	\
 	do {					\
-		typeof(l1__->list[0]) p1__;	\
-		typeof(l2__->list[0]) p2__;	\
+		typeof(l1__->list) p1__;	\
+		typeof(l2__->list) p2__;	\
 		PREPARE_PTR_LIST(l1__, p1__);	\
 		FOR_EACH_PTR(l2__, p2__)	\
 			expr__;			\
diff --git a/ptrlist.h b/ptrlist.h
index b42a0ca..6f1a289 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -11,10 +11,10 @@
 	(type *)((void *)(ptr) - offsetof(type, member))
 
 /* Silly type-safety check ;) */
-#define DECLARE_PTR_LIST(listname,type)	struct listname { type *list[1]; }
-#define CHECK_TYPE(head,ptr)		(void)(&(ptr) == &(head)->list[0])
-#define TYPEOF(head)			__typeof__(&(head)->list[0])
-#define VRFY_PTR_LIST(head)		(void)(sizeof((head)->list[0]))
+#define DECLARE_PTR_LIST(listname,type)	struct listname { type *list; }
+#define CHECK_TYPE(head,ptr)		(void)(&(ptr) == &(head)->list)
+#define TYPEOF(head)			__typeof__(&(head)->list)
+#define VRFY_PTR_LIST(head)		(void)(sizeof((head)->list))
 
 #define LIST_NODE_NR (29)
 

-- 
Alecs King

From: Michael Buesch <mb@bu3sch.de>
Subject: [PATCH] sparse: Add more ignored attributes
Date: Wed, 25 Nov 2009 14:29:17 +0100
Message-ID: <200911251429.18554.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from bu3sch.de ([62.75.166.246]:55478 "EHLO vs166246.vserver.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933159AbZKYNac (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 25 Nov 2009 08:30:32 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: linux-sparse@vger.kernel.org

This adds more ignored gcc-style attributes.

externally_visible is a standard gcc attribute.
signal is an AVR8 attribute used to define interrupt service routines.

Ignore these attributes, as they are currently not useful for sparse checking.

Signed-off-by: Michael Buesch <mb@bu3sch.de>

---

Index: sparse/parse.c
===================================================================
--- sparse.orig/parse.c	2009-11-24 23:44:37.000000000 +0100
+++ sparse/parse.c	2009-11-25 14:21:39.000000000 +0100
@@ -541,6 +541,10 @@ static struct init_keyword {
 	{ "__warning__",	NS_KEYWORD,	.op = &ignore_attr_op },
 	{ "bounded",	NS_KEYWORD,	.op = &ignore_attr_op },
 	{ "__bounded__",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "externally_visible",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__externally_visible__",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "signal",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__signal__",	NS_KEYWORD,	.op = &ignore_attr_op },
 };
 
 void init_parser(int stream)

-- 
Greetings, Michael.

From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] ignore __cold__ attribute
Date: Tue, 22 Apr 2008 12:41:23 +0200
Message-ID: <1208860883.31429.8.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:38586 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754783AbYDVKl7 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 Apr 2008 06:41:59 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse <linux-sparse@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>

This is a new attribute in gcc 4.3, which when used and sparse is
compiled with gcc 4.3 leads to unknown attribute errors. Ignore it.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
diff --git a/parse.c b/parse.c
index 83e2d67..cdcd742 100644
--- a/parse.c
+++ b/parse.c
@@ -355,6 +355,7 @@ static struct init_keyword {
 	{ "__constructor__",	NS_KEYWORD,	.op = &ignore_attr_op },
 	{ "destructor",	NS_KEYWORD,	.op = &ignore_attr_op },
 	{ "__destructor__",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__cold__",	NS_KEYWORD,	.op = &ignore_attr_op },
 };
 
 void init_parser(int stream)



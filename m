From: Emil Medve <Emilian.Medve@Freescale.com>
Subject: [PATCH] Handle ignored attribute malloc
Date: Thu, 25 Oct 2007 16:12:49 -0500
Message-ID: <1193346769-18030-1-git-send-email-Emilian.Medve@Freescale.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from az33egw02.freescale.net ([192.88.158.103]:62892 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755199AbXJYVWN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 25 Oct 2007 17:22:13 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: josh@freedesktop.org, linux-sparse@vger.kernel.org
Cc: Emil Medve <Emilian.Medve@Freescale.com>

This avoids error messages like this:

error: attribute 'malloc': unknown attribute

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---

Please copy me in replies as I'm not subscribed to the list

 ident-list.h |    1 +
 parse.c      |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/ident-list.h b/ident-list.h
index b183eac..8fcd7de 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -69,6 +69,7 @@ IDENT(model); IDENT(__model__);
 IDENT(format_arg); IDENT(__format_arg__);
 IDENT(nothrow); IDENT(__nothrow); IDENT(__nothrow__);
 IDENT(__transparent_union__);
+IDENT(malloc);
 IDENT(__malloc__);
 IDENT(nonnull); IDENT(__nonnull); IDENT(__nonnull__);
 IDENT(constructor); IDENT(__constructor__);
diff --git a/parse.c b/parse.c
index 47b5204..a41939d 100644
--- a/parse.c
+++ b/parse.c
@@ -283,6 +283,7 @@ static struct init_keyword {
 	{ "nothrow",	NS_KEYWORD,	.op = &ignore_attr_op },
 	{ "__nothrow",	NS_KEYWORD,	.op = &ignore_attr_op },
 	{ "__nothrow__",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "malloc",	NS_KEYWORD,	.op = &ignore_attr_op },
 	{ "__malloc__",	NS_KEYWORD,	.op = &ignore_attr_op },
 	{ "nonnull",	NS_KEYWORD,	.op = &ignore_attr_op },
 	{ "__nonnull",	NS_KEYWORD,	.op = &ignore_attr_op },
-- 
1.5.3.GIT

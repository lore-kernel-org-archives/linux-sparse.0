From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Ignore "cold" and "hot" attributes, which appeared in gcc 4.3
Date: Fri, 25 Apr 2008 04:25:35 -0400
Message-ID: <20080425082534.7034.76060.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:64462 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841AbYDYIZh (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 25 Apr 2008 04:25:37 -0400
Received: from dv.roinet.com (static-72-92-88-10.phlapa.fios.verizon.net [72.92.88.10])
	by relay.cesmail.net (Postfix) with ESMTP id E56FB619058
	for <linux-sparse@vger.kernel.org>; Fri, 25 Apr 2008 04:25:35 -0400 (EDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

They describe how likely the function is to be executed, which can
affect optimization.  Also ignore attributes with underscores.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 ident-list.h |    2 ++
 parse.c      |    4 ++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/ident-list.h b/ident-list.h
index 8fcd7de..6104826 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -74,6 +74,8 @@ IDENT(__malloc__);
 IDENT(nonnull); IDENT(__nonnull); IDENT(__nonnull__);
 IDENT(constructor); IDENT(__constructor__);
 IDENT(destructor); IDENT(__destructor__);
+IDENT(cold); IDENT(__cold__);
+IDENT(hot); IDENT(__hot__);
 IDENT(cdecl); IDENT(__cdecl__);
 IDENT(stdcall); IDENT(__stdcall__);
 IDENT(fastcall); IDENT(__fastcall__);
diff --git a/parse.c b/parse.c
index 137ba77..877414c 100644
--- a/parse.c
+++ b/parse.c
@@ -353,6 +353,10 @@ static struct init_keyword {
 	{ "__constructor__",	NS_KEYWORD,	.op = &ignore_attr_op },
 	{ "destructor",	NS_KEYWORD,	.op = &ignore_attr_op },
 	{ "__destructor__",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "cold",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__cold__",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "hot",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__hot__",	NS_KEYWORD,	.op = &ignore_attr_op },
 };
 
 void init_parser(int stream)

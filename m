From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 12/18] Saner type for __builtin_va_list
Date: Mon, 09 Mar 2009 07:12:08 +0000
Message-ID: <E1LgZei-0000xH-1z@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:43778 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267AbZCIHMJ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Mar 2009 03:12:09 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LgZei-0000xH-1z
	for linux-sparse@vger.kernel.org; Mon, 09 Mar 2009 07:12:08 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 parse.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/parse.c b/parse.c
index a9156c9..04a4227 100644
--- a/parse.c
+++ b/parse.c
@@ -232,7 +232,7 @@ static struct init_keyword {
 		.op = &spec_op },
 
 	/* Predeclared types */
-	{ "__builtin_va_list", NS_TYPEDEF, .type = &int_type, .op = &spec_op },
+	{ "__builtin_va_list", NS_TYPEDEF, .type = &ptr_ctype, .op = &spec_op },
 
 	/* Extended types */
 	{ "typeof", 	NS_TYPEDEF, .op = &typeof_op },
-- 
1.5.6.5



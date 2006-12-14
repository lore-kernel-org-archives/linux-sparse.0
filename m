From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: [PATCH] dissect: cleanup report_implicit()
Date: Fri, 15 Dec 2006 00:37:40 +0300
Message-ID: <20061214213740.GC422@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.sgg.ru ([217.23.135.1]:41622 "EHLO mail.sgg.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751986AbWLNXki (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 14 Dec 2006 18:40:38 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

It doesn't make sense to do report_implicit() for the anonymous structures,
check "type->ident != NULL".

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- DS/dissect.c~	2006-04-21 00:04:14.000000000 +0400
+++ DS/dissect.c	2006-04-21 01:04:14.000000000 +0400
@@ -130,12 +130,14 @@ static void report_implicit(usage_t mode
 	if (type->type != SYM_STRUCT && type->type != SYM_UNION)
 		return;
 
-	if (reporter->r_member) {
+	if (!reporter->r_member)
+		return;
+
+	if (type->ident != NULL)
 		reporter->r_member(mode, pos, type, NULL);
 
-		DO_LIST(type->symbol_list, mem,
-			report_implicit(mode, pos, base_type(mem)));
-	}
+	DO_LIST(type->symbol_list, mem,
+		report_implicit(mode, pos, base_type(mem)));
 }
 
 static inline struct symbol *expr_symbol(struct expression *expr)

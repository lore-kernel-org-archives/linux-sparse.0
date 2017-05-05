From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/6] keyword: add a comment about NS_TYPEDEF & reserved keywords
Date: Fri,  5 May 2017 03:50:33 +0200
Message-ID: <20170505015034.65164-6-luc.vanoostenryck@gmail.com>
References: <20170505015034.65164-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33251 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752330AbdEEBwD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 4 May 2017 21:52:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id y10so6887141wmh.0
        for <linux-sparse@vger.kernel.org>; Thu, 04 May 2017 18:52:03 -0700 (PDT)
In-Reply-To: <20170505015034.65164-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

There is two ways a keyword can be marked as reserved:
- explicitly, by using IDENT_RESERVED() in "ident-list.h"
- implicitly, by using NS_TYPEDEF as namespace in parse.c::keyword_table

Since the implicit way is not obvious, help to make it more clear
by adding a small comment on top of keyword_table[].

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/parse.c b/parse.c
index eefc0c330..b2bef64f0 100644
--- a/parse.c
+++ b/parse.c
@@ -407,6 +407,7 @@ static struct symbol_op mode_word_op = {
 	.to_mode = to_word_mode
 };
 
+/* Using NS_TYPEDEF will also make the keyword a reserved one */
 static struct init_keyword {
 	const char *name;
 	enum namespace ns;
-- 
2.12.0


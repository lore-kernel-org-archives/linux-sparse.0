From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/3] move up apply_ctype()'s declaration
Date: Mon, 22 Jan 2018 07:36:04 +0100
Message-ID: <20180122063605.97737-3-luc.vanoostenryck@gmail.com>
References: <20180122063605.97737-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:45772 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbeAVGgS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 22 Jan 2018 01:36:18 -0500
Received: by mail-wm0-f68.google.com with SMTP id i186so14097843wmi.4
        for <linux-sparse@vger.kernel.org>; Sun, 21 Jan 2018 22:36:18 -0800 (PST)
In-Reply-To: <20180122063605.97737-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

No functional changes, just to make the following patch
more readable.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/parse.c b/parse.c
index e255345fd..a60fcff45 100644
--- a/parse.c
+++ b/parse.c
@@ -627,6 +627,8 @@ struct statement *alloc_statement(struct position pos, int type)
 
 static struct token *struct_declaration_list(struct token *token, struct symbol_list **list);
 
+static void apply_ctype(struct position pos, struct ctype *thistype, struct ctype *ctype);
+
 static void apply_modifiers(struct position pos, struct decl_state *ctx)
 {
 	struct symbol *ctype;
@@ -962,8 +964,6 @@ static struct token *enum_specifier(struct token *token, struct decl_state *ctx)
 	return ret;
 }
 
-static void apply_ctype(struct position pos, struct ctype *thistype, struct ctype *ctype);

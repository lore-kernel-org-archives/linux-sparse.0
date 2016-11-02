From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] cleanup: remove unused field 'string' in struct symbol
Date: Wed,  2 Nov 2016 18:16:45 +0100
Message-ID: <20161102171645.17933-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36389 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932380AbcKBRSv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Nov 2016 13:18:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id c17so4040216wmc.3
        for <linux-sparse@vger.kernel.org>; Wed, 02 Nov 2016 10:18:50 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This field is never used, better to remove it.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 1 -
 symbol.h   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index b45a3958..566f0c83 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -90,7 +90,6 @@ static struct symbol *evaluate_string(struct expression *expr)
 	sym->array_size = alloc_const_expression(expr->pos, length);
 	sym->bit_size = bytes_to_bits(length);
 	sym->ctype.alignment = 1;
-	sym->string = 1;
 	sym->ctype.modifiers = MOD_STATIC;
 	sym->ctype.base_type = array;
 	sym->initializer = initstr;
diff --git a/symbol.h b/symbol.h
index 9b3f1604..b26fbbc4 100644
--- a/symbol.h
+++ b/symbol.h
@@ -172,7 +172,6 @@ struct symbol {
 					examined:1,
 					expanding:1,
 					evaluated:1,
-					string:1,
 					designated_init:1,
 					forced_arg:1,
 					transparent_union:1;
-- 
2.10.1


From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 5/6] remove alignment from struct access_data
Date: Sat,  8 Apr 2017 23:19:00 +0200
Message-ID: <20170408211901.40507-6-luc.vanoostenryck@gmail.com>
References: <20170408211901.40507-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33559 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752292AbdDHVTR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 8 Apr 2017 17:19:17 -0400
Received: by mail-wm0-f66.google.com with SMTP id o81so3595966wmb.0
        for <linux-sparse@vger.kernel.org>; Sat, 08 Apr 2017 14:19:16 -0700 (PDT)
In-Reply-To: <20170408211901.40507-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In struct access_data, the field 'alignment' is always
the one present in 'result_type' and is thus completely
redundant.

Change this by removing this field.
---
 linearize.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/linearize.c b/linearize.c
index f628f5a74..1f93da9ae 100644
--- a/linearize.c
+++ b/linearize.c
@@ -844,7 +844,7 @@ struct access_data {
 	struct symbol *source_type;	// source ctype
 	pseudo_t address;		// pseudo containing address ..
 	pseudo_t origval;		// pseudo for original value ..
-	unsigned int offset, alignment;	// byte offset
+	unsigned int offset;		// byte offset
 	struct position pos;
 };
 
@@ -897,7 +897,6 @@ static int linearize_address_gen(struct entrypoint *ep,
 	ad->pos = expr->pos;
 	ad->result_type = ctype;
 	ad->source_type = base_type(ctype);
-	ad->alignment = ctype->ctype.alignment;
 	if (expr->type == EXPR_PREOP && expr->op == '*')
 		return linearize_simple_address(ep, expr->unop, ad);
 
-- 
2.12.0


From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 07/48] topasm: top-level asm is special
Date: Wed, 23 Aug 2017 22:15:13 +0200
Message-ID: <20170823201554.90551-8-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36863 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932443AbdHWUQP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:16:15 -0400
Received: by mail-wm0-f66.google.com with SMTP id f127so639711wmf.3
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:16:14 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Top-level asm is parsed as a fake anonymous function.

Obviously it also doesn't have a return type and such
and this may complicate things if we continue to treat it
as a function.

Avoid potential problems by special casing it and returning
early in linearize_fn().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/linearize.c b/linearize.c
index e3d234e7e..298991dcd 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2200,6 +2200,11 @@ static struct entrypoint *linearize_fn(struct symbol *sym, struct symbol *base_t
 	add_one_insn(ep, entry);
 	ep->entry = entry;
 
+	if (!sym->ident) {	// top-level asm
+		linearize_statement(ep, base_type->stmt);
+		return ep;
+	}
+
 	concat_symbol_list(base_type->arguments, &ep->syms);
 
 	/* FIXME!! We should do something else about varargs.. */
-- 
2.14.0


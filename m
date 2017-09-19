From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] remove prototype for unexistant examine_simple_symbol_type()
Date: Tue, 19 Sep 2017 05:08:40 +0200
Message-ID: <20170919030840.12525-3-luc.vanoostenryck@gmail.com>
References: <20170919030840.12525-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37176 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbdISDIr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 Sep 2017 23:08:47 -0400
Received: by mail-wr0-f195.google.com with SMTP id u48so1397533wrf.4
        for <linux-sparse@vger.kernel.org>; Mon, 18 Sep 2017 20:08:47 -0700 (PDT)
In-Reply-To: <20170919030840.12525-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/symbol.h b/symbol.h
index 614763404..0c50884af 100644
--- a/symbol.h
+++ b/symbol.h
@@ -303,7 +303,6 @@ extern void bind_symbol(struct symbol *, struct ident *, enum namespace);
 
 extern struct symbol *examine_symbol_type(struct symbol *);
 extern struct symbol *examine_pointer_target(struct symbol *);
-extern void examine_simple_symbol_type(struct symbol *);
 extern const char *show_typename(struct symbol *sym);
 extern const char *builtin_typename(struct symbol *sym);
 extern const char *builtin_ctypename(struct ctype *ctype);
-- 
2.14.0


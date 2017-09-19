From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/5] add helper: valid_type()
Date: Tue, 19 Sep 2017 04:13:32 +0200
Message-ID: <20170919021335.5881-3-luc.vanoostenryck@gmail.com>
References: <20170919021335.5881-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33624 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbdISCNn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 Sep 2017 22:13:43 -0400
Received: by mail-wm0-f65.google.com with SMTP id m127so2500063wmm.0
        for <linux-sparse@vger.kernel.org>; Mon, 18 Sep 2017 19:13:42 -0700 (PDT)
In-Reply-To: <20170919021335.5881-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/symbol.h b/symbol.h
index 327449611..230057d1d 100644
--- a/symbol.h
+++ b/symbol.h
@@ -313,6 +313,11 @@ extern void debug_symbol(struct symbol *);
 extern void merge_type(struct symbol *sym, struct symbol *base_type);
 extern void check_declaration(struct symbol *sym);
 
+static inline int valid_type(const struct symbol *ctype)
+{
+	return ctype && ctype != &bad_ctype;
+}
+
 static inline struct symbol *get_base_type(const struct symbol *sym)
 {
 	return examine_symbol_type(sym->ctype.base_type);
-- 
2.14.0


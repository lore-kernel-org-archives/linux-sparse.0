From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/8] add helper: valid_type()
Date: Fri,  2 Feb 2018 13:17:31 +0100
Message-ID: <20180202121735.39621-5-luc.vanoostenryck@gmail.com>
References: <20180202121735.39621-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35873 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751569AbeBBMTv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 2 Feb 2018 07:19:51 -0500
Received: by mail-wm0-f68.google.com with SMTP id f3so12004289wmc.1
        for <linux-sparse@vger.kernel.org>; Fri, 02 Feb 2018 04:19:51 -0800 (PST)
In-Reply-To: <20180202121735.39621-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

'bad_type' is used for ... bad types instead of NULL
in order to avoid later lots of null-checking.

Alas NULL is also often used and so we have to check
for NULL and 'bad_ctype' when checking a type's validity.

Add an helper: valid_type() to make the code a bit simpler.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/symbol.h b/symbol.h
index fd5746429..b4d1c2acc 100644
--- a/symbol.h
+++ b/symbol.h
@@ -309,6 +309,11 @@ extern void debug_symbol(struct symbol *);
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
2.16.0


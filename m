From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 05/13] add get_nth1_arg()
Date: Sun,  5 Mar 2017 12:20:39 +0100
Message-ID: <20170305112047.3411-6-luc.vanoostenryck@gmail.com>
References: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32907 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752308AbdCEL3f (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Mar 2017 06:29:35 -0500
Received: by mail-wm0-f68.google.com with SMTP id n11so9500458wma.0
        for <linux-sparse@vger.kernel.org>; Sun, 05 Mar 2017 03:29:34 -0800 (PST)
In-Reply-To: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

A backend may need to know the size or the type of an
argument and there is no easy way to access to this info.

Fix this by adding an helper returning the symbol associated
to the nth argument (starting at 1).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/symbol.h b/symbol.h
index 36f8345b5..2bc0e21a0 100644
--- a/symbol.h
+++ b/symbol.h
@@ -416,6 +416,19 @@ static inline int get_sym_type(struct symbol *type)
 	return type->type;
 }
 
+static inline struct symbol *get_nth1_arg(struct symbol *fn, int idx)
+{
+	struct symbol_list *args = fn->ctype.base_type->arguments;
+	struct symbol *arg;
+	int i = 0;
+	FOR_EACH_PTR(args, arg) {
+		if (++i == idx)
+			return arg;
+	} END_FOR_EACH_PTR(arg);
+
+	return NULL;
+}
+
 static inline struct symbol *lookup_keyword(struct ident *ident, enum namespace ns)
 {
 	if (!ident->keyword)
-- 
2.11.1


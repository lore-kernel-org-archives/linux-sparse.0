From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/6] let -dD report #undef too
Date: Tue,  4 Apr 2017 23:49:54 +0200
Message-ID: <20170404214955.47926-6-luc.vanoostenryck@gmail.com>
References: <20170404214955.47926-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35633 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754782AbdDDVuP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 4 Apr 2017 17:50:15 -0400
Received: by mail-wm0-f67.google.com with SMTP id z133so8025168wmb.2
        for <linux-sparse@vger.kernel.org>; Tue, 04 Apr 2017 14:50:15 -0700 (PDT)
In-Reply-To: <20170404214955.47926-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 pre-process.c                         | 3 +++
 validation/preprocessor/dump-macros.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/pre-process.c b/pre-process.c
index 74414dfeb..63df3f71c 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -1406,6 +1406,7 @@ static int do_handle_undef(struct stream *stream, struct token **line, struct to
 	if (!sym || sym->scope != file_scope) {
 		sym = alloc_symbol(left->pos, SYM_NODE);
 		bind_symbol(sym, left->ident, NS_MACRO);
+		add_ident(&macros, left->ident);
 	}
 
 	sym->namespace = NS_UNDEF;
@@ -2063,5 +2064,7 @@ void dump_macro_definitions(void)
 		struct symbol *sym = lookup_macro(name);
 		if (sym)
 			dump_macro(sym);
+		else
+			printf("#undef %s\n", show_ident(name));
 	} END_FOR_EACH_PTR(name);
 }
diff --git a/validation/preprocessor/dump-macros.c b/validation/preprocessor/dump-macros.c
index 79f3de6a2..5508233aa 100644
--- a/validation/preprocessor/dump-macros.c
+++ b/validation/preprocessor/dump-macros.c
@@ -15,4 +15,5 @@ check-output-pattern-1-times: #define __CHECKER__ 1
 check-output-contains: #define IJK ijk
 check-output-contains: #define DEF xyz
 check-output-contains: #define NYDEF ydef
+check-output-contains: #undef ABC
  */
-- 
2.12.0


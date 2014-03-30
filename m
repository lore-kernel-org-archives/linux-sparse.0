From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/2] Use any previous initializer to size a symbol
Date: Sun, 30 Mar 2014 10:22:35 -0700 (PDT)
Message-ID: <alpine.LFD.2.11.1403301020530.16374@i7.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:57760 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbaC3RWh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 30 Mar 2014 13:22:37 -0400
Received: by mail-pb0-f53.google.com with SMTP id rp16so7151005pbb.12
        for <linux-sparse@vger.kernel.org>; Sun, 30 Mar 2014 10:22:37 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, Hans Verkuil <hverkuil@xs4all.nl>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 30 Mar 2014 10:13:54 -0700
Subject: [PATCH 2/2] Use any previous initializer to size a symbol

When we size a symbol, we only have one initializer per symbol, but we
may have multiple symbol declarations for the same symbol.  So make sure
to walk the "same_symbol" chain to find the initializer, rather than
assuming it is attached to the current declaration.

Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This seems to be the simplest approach. Chris, what was your concern about 
scoping? The "same_symbol" list should already take scoping into account.

 symbol.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/symbol.c b/symbol.c
index eb6e1215ee87..4b91abd8021e 100644
--- a/symbol.c
+++ b/symbol.c
@@ -354,6 +354,15 @@ static int count_array_initializer(struct symbol *t, struct expression *expr)
 	return nr;
 }
 
+static struct expression *get_symbol_initializer(struct symbol *sym)
+{
+	do {
+		if (sym->initializer)
+			return sym->initializer;
+	} while ((sym = sym->same_symbol) != NULL);
+	return NULL;
+}
+
 static struct symbol * examine_node_type(struct symbol *sym)
 {
 	struct symbol *base_type = examine_base_type(sym);
@@ -376,12 +385,15 @@ static struct symbol * examine_node_type(struct symbol *sym)
 		sym->ctype.alignment = alignment;
 
 	/* Unsized array? The size might come from the initializer.. */
-	if (bit_size < 0 && base_type->type == SYM_ARRAY && sym->initializer) {
-		struct symbol *node_type = base_type->ctype.base_type;
-		int count = count_array_initializer(node_type, sym->initializer);

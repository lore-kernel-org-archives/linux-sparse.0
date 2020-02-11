From: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH] dissect: move __sparse() callsite from test-dissect.c to
 dissect.c
Date: Tue, 11 Feb 2020 18:04:15 +0100
Message-ID: <20200211170415.GA18497@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57146 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728369AbgBKREW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 11 Feb 2020 12:04:22 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

This is more flexible. For example, we can change dissect() to inspect
file_scope->symbols too without changing its callers.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c      |  5 +++--
 dissect.h      |  2 +-
 test-dissect.c | 11 ++---------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/dissect.c b/dissect.c
index 823a348..499e0a0 100644
--- a/dissect.c
+++ b/dissect.c
@@ -642,8 +642,9 @@ static void do_sym_list(struct symbol_list *list)
 	DO_LIST(list, sym, do_symbol(sym));
 }
 
-void dissect(struct symbol_list *list, struct reporter *rep)
+void dissect(struct reporter *rep, struct string_list *filelist)
 {
 	reporter = rep;
-	do_sym_list(list);
+
+	DO_LIST(filelist, file, do_sym_list(__sparse(file)));
 }
diff --git a/dissect.h b/dissect.h
index 178dba5..326d3dc 100644
--- a/dissect.h
+++ b/dissect.h
@@ -32,6 +32,6 @@ static inline bool sym_is_local(struct symbol *sym)
 	return sym->kind == 'v' && !(sym->ctype.modifiers & MOD_TOPLEVEL);
 }
 
-extern void dissect(struct symbol_list *, struct reporter *);
+extern void dissect(struct reporter *, struct string_list *);
 
 #endif
diff --git a/test-dissect.c b/test-dissect.c
index c4b454c..4b2d3be 100644
--- a/test-dissect.c
+++ b/test-dissect.c
@@ -1,7 +1,5 @@
 #include "dissect.h"
 
-static unsigned dotc_stream;
-
 static inline const char *show_mode(unsigned mode)
 {
 	static char str[3];
@@ -119,15 +117,10 @@ int main(int argc, char **argv)
 		.r_symbol = r_symbol,
 		.r_member = r_member,
 	};
-	struct string_list *filelist = NULL;
-	char *file;
 
+	struct string_list *filelist = NULL;
 	sparse_initialize(argc, argv, &filelist);

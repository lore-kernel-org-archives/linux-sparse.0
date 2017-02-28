From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 7/7] move check extern with initializer to default_process_decl()
Date: Tue, 28 Feb 2017 11:04:03 +0100
Message-ID: <20170228100403.33184-8-luc.vanoostenryck@gmail.com>
References: <20170228094635.qbod5dwqwrw6etvt@macbook.local>
 <20170228100403.33184-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35286 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751639AbdB1KGk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Feb 2017 05:06:40 -0500
Received: by mail-wr0-f194.google.com with SMTP id q39so962959wrb.2
        for <linux-sparse@vger.kernel.org>; Tue, 28 Feb 2017 02:06:17 -0800 (PST)
In-Reply-To: <20170228100403.33184-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The call to the method external_decl::process_decl() is
preceded by some processing if there is also an initializer.
Part of this processing is a check if the declaration has not
external linkage, otherwise an error is issued and the
'extern' is removed from the declaration.

While also valid for C99 for-loop initializer, this is less
desirable because in this context, 'extern' is invalid anyway
and removing it from the declaration make it imposible to issue
a diagnostic about it.

Fix this by moving the 'extern with initializer' check into the
default_process_decl() method, where it is always pertinent and
so allowing process_for_loop_decl() to make its own diagnostic.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c                        | 8 ++++----
 validation/c99-for-loop-decl.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/parse.c b/parse.c
index c3c877b10..e33e8b32f 100644
--- a/parse.c
+++ b/parse.c
@@ -2899,10 +2899,6 @@ static struct token *external_decl(struct token *token, process_decl_t process_d
 		int has_init = 0;
 		if (!is_typedef && match_op(token, '=')) {
 			has_init = 1;
-			if (decl->ctype.modifiers & MOD_EXTERN) {
-				warning(decl->pos, "symbol with external linkage has initializer");
-				decl->ctype.modifiers &= ~MOD_EXTERN;
-			}
 			token = initializer(&decl->initializer, token->next);
 		}
 		if (!is_typedef)
@@ -2949,6 +2945,10 @@ static struct token *external_decl(struct token *token, process_decl_t process_d
 
 static void default_process_decl(struct symbol_list **list, struct symbol *decl, int has_init)
 {
+	if (has_init && decl->ctype.modifiers & MOD_EXTERN) {
+		warning(decl->pos, "symbol with external linkage has initializer");
+		decl->ctype.modifiers &= ~MOD_EXTERN;
+	}
 	if (!(decl->ctype.modifiers & (MOD_EXTERN | MOD_INLINE))) {
 		add_symbol(list, decl);
 		fn_local_symbol(decl);
diff --git a/validation/c99-for-loop-decl.c b/validation/c99-for-loop-decl.c
index e813b0ae3..d382d3c9b 100644
--- a/validation/c99-for-loop-decl.c
+++ b/validation/c99-for-loop-decl.c
@@ -32,7 +32,7 @@ static int c99(void)
  * check-name: C99 for-loop declarations
  *
  * check-error-start
-c99-for-loop-decl.c:22:27: warning: symbol with external linkage has initializer
+c99-for-loop-decl.c:22:27: error: non-local var 'l' in for-loop initializer
 c99-for-loop-decl.c:24:27: error: non-local var 'm' in for-loop initializer
 c99-for-loop-decl.c:26:27: error: non-local var 'n' in for-loop initializer
 c99-for-loop-decl.c:9:16: error: undefined identifier 'i'
-- 
2.11.1


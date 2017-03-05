From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 6/6] move 'extern with initializer' validation after the validate method
Date: Sun,  5 Mar 2017 20:21:52 +0100
Message-ID: <20170305192152.67931-7-luc.vanoostenryck@gmail.com>
References: <CANeU7Qk34VzZ6Q2oxEcFrreK=NOwmpSGbiVgvyckpp154xWJaQ@mail.gmail.com>
 <20170305192152.67931-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36528 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752398AbdCETWl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Mar 2017 14:22:41 -0500
Received: by mail-wm0-f68.google.com with SMTP id v190so10657071wme.3
        for <linux-sparse@vger.kernel.org>; Sun, 05 Mar 2017 11:22:05 -0800 (PST)
In-Reply-To: <20170305192152.67931-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Before the call to the method external_decl::validate_decl()
there is another validation done which check if the declaration
linkage is not external, otherwise an error is issued and the
'extern' is removed from the declaration.

While also valid for C99 for-loop initializer, this is less
desirable because in this context, 'extern' is invalid anyway
and removing it from the declaration make it imposible to issue
a diagnostic about it.

Fix this by moving the 'extern with initializer' check after the
call to validate_decl() method, where it is always pertinent and
so allowing process_for_loop_decl() to make its own diagnostic.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c                        | 9 +++++----
 validation/c99-for-loop-decl.c | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/parse.c b/parse.c
index 6ec1bab97..80f0337cc 100644
--- a/parse.c
+++ b/parse.c
@@ -2890,16 +2890,17 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 
 	for (;;) {
 		if (!is_typedef && match_op(token, '=')) {
-			if (decl->ctype.modifiers & MOD_EXTERN) {
-				warning(decl->pos, "symbol with external linkage has initializer");
-				decl->ctype.modifiers &= ~MOD_EXTERN;
-			}
 			token = initializer(&decl->initializer, token->next);
 		}
 		if (!is_typedef) {
 			if (validate_decl)
 				validate_decl(decl);
 
+			if (decl->initializer && decl->ctype.modifiers & MOD_EXTERN) {
+				warning(decl->pos, "symbol with external linkage has initializer");
+				decl->ctype.modifiers &= ~MOD_EXTERN;
+			}
+
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


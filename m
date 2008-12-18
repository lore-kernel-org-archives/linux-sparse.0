From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 01/16] Add enum member list to the parent
Date: Fri, 19 Dec 2008 00:51:22 +0300
Message-ID: <20081218215122.28136.63238.stgit@zaytsev.su>
References: <20081218181935.28136.60256.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:3891 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbYLRVmJ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 18 Dec 2008 16:42:09 -0500
Received: by ug-out-1314.google.com with SMTP id 39so508415ugf.37
        for <linux-sparse@vger.kernel.org>; Thu, 18 Dec 2008 13:42:06 -0800 (PST)
In-Reply-To: <20081218181935.28136.60256.stgit@zaytsev.su>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

From: Christopher Li <sparse@chrisli.org>

Signed-Off-By: Christopher Li <sparse@chrisli.org>
Acked-by: Thomas Schmid <Thomas.Schmid@br-automation.com>
---
 parse.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/parse.c b/parse.c
index 915ae20..eb31871 100644
--- a/parse.c
+++ b/parse.c
@@ -665,7 +665,6 @@ static struct token *parse_enum_declaration(struct token *token, struct symbol *
 	unsigned long long lastval = 0;
 	struct symbol *ctype = NULL, *base_type = NULL;
 	Num upper = {-1, 0}, lower = {1, 0};
-	struct symbol_list *entries = NULL;
 
 	parent->examined = 1;
 	parent->ctype.base_type = &int_ctype;
@@ -701,7 +700,7 @@ static struct token *parse_enum_declaration(struct token *token, struct symbol *
 		sym->initializer = expr;
 		sym->enum_member = 1;
 		sym->ctype.base_type = parent;
-		add_ptr_list(&entries, sym);
+		add_ptr_list(&parent->symbol_list, sym);
 
 		if (base_type != &bad_ctype) {
 			if (ctype->type == SYM_NODE)
@@ -777,8 +776,7 @@ static struct token *parse_enum_declaration(struct token *token, struct symbol *
 	parent->ctype.modifiers |= (base_type->ctype.modifiers & MOD_UNSIGNED);
 	parent->examined = 0;
 
-	cast_enum_list(entries, base_type);
-	free_ptr_list(&entries);
+	cast_enum_list(parent->symbol_list, base_type);
 
 	return token;
 }


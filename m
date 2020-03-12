From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] cpp: silently allow conditional directives within macro
Date: Thu, 12 Mar 2020 22:16:30 +0100
Message-ID: <20200312211630.53710-1-luc.vanoostenryck@gmail.com>
References: <CAHk-=wiNPBt4wNkfgSd_utshPkjqQv-z7cg5iCji2jbFAUrLkg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32979 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgCLVQh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 12 Mar 2020 17:16:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id a25so9426125wrd.0
        for <linux-sparse@vger.kernel.org>; Thu, 12 Mar 2020 14:16:36 -0700 (PDT)
In-Reply-To: <CAHk-=wiNPBt4wNkfgSd_utshPkjqQv-z7cg5iCji2jbFAUrLkg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The presence of preprocessor directives within the arguments
of a macro invocation is Undefined Behaviour [6.10.3p11].
However, conditional directives are harmless here and are
useful (and commonly used in the kernel).

So, relax the warning by restricting it to non-conditional
directives.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 pre-process.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index 6670fb0cd557..4b2cd054f897 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -48,6 +48,7 @@ static struct ident_list *macros;	// only needed for -dD
 static int false_nesting = 0;
 static int counter_macro = 0;		// __COUNTER__ expansion
 static int include_level = 0;
+static int expanding = 0;
 
 #define INCLUDEPATHS 300
 const char *includepath[INCLUDEPATHS+1] = {
@@ -232,8 +233,13 @@ static int expand_one_symbol(struct token **list)
 		sym->expander(token);
 		return 1;
 	} else {
+		int rc;
+
 		sym->used_in = file_scope;
-		return expand(list, sym);
+		expanding = 1;
+		rc = expand(list, sym);
+		expanding = 0;
+		return rc;
 	}
 }
 
@@ -271,9 +277,6 @@ static struct token *collect_arg(struct token *prev, int vararg, struct position
 	while (!eof_token(next = scan_next(p))) {
 		if (next->pos.newline && match_op(next, '#')) {
 			if (!next->pos.noexpand) {
-				if (Wdirective_within_macro)
-					warning(next->pos,
-						"directive in macro's argument list");
 				preprocessor_line(stream, p);
 				__free_token(next);	/* Free the '#' token */
 				continue;
@@ -2075,6 +2078,7 @@ static void handle_preprocessor_line(struct stream *stream, struct token **line,
 	int (*handler)(struct stream *, struct token **, struct token *);
 	struct token *token = start->next;
 	int is_normal = 1;
+	int is_cond = 0;	// is one of {is,ifdef,ifndef,elif,else,endif}
 
 	if (eof_token(token))
 		return;
@@ -2084,6 +2088,7 @@ static void handle_preprocessor_line(struct stream *stream, struct token **line,
 		if (sym) {
 			handler = sym->handler;
 			is_normal = sym->normal;
+			is_cond = !sym->normal;
 		} else {
 			handler = handle_nondirective;
 		}
@@ -2098,6 +2103,12 @@ static void handle_preprocessor_line(struct stream *stream, struct token **line,
 		if (false_nesting)
 			goto out;
 	}
+
+	if (expanding) {
+		if (Wdirective_within_macro && !is_cond)
+			warning(start->pos, "directive in macro's argument list");
+		expanding = 0;		// warn only once
+	}
 	if (!handler(stream, line, token))	/* all set */
 		return;
 
-- 
2.25.1

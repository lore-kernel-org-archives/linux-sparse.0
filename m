From: foobar <foobar@redchan.it>
Subject: [RFC] proper handling of #pragma
Date: Wed, 3 Jan 2018 16:14:19 +0000
Message-ID: <20180103161419.a43208d5469c43ff36b3d2e1@redchan.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from cock.li ([185.100.85.212]:40681 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751195AbeACQO6 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 3 Jan 2018 11:14:58 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: foobar@redchan.it

#pragma directives other than #pragma once are not really meant for the preprocessor to consume.

in preprocessor_only mode, apart from pragma once, they should all be printed to stdout (unless they are under #ifdef that's not taken).

i've produced a patch that does that, however i'm not really happy about it, since i'm unclear about how to deal
with the pragma in non-preprocessor mode.

i suppose the token-stream of the pragma-directive should be converted into some kind of special symbol, which can then be either consumed or ignored when doing the usual iteration over the symbol list.
but i didn't find an obvious symbol type to assign...

(my plan is to create a build tool based on sparse that gets directives as a special pragma).

thanks!

testcode:
#pragma once
#if 1
#pragma omp wanna "see this" in cpp output
#else
#pragma omp nope "this one not"
#endif

here's the initial version of my patch

Subject: [PATCH] preprocessor: properly emit #pragma directives

3 months after the first commit, handling of pragma directives was
implemented, with the idea of turning the token into __pragma__ for
later internal consumption. however never anything came out of this idea,
and #pragma was basically left broken. apart from #pragma once, the
directive needs to persist in the preprocessor output, it is for later
consumption of the compiler (apparently the assumption was that sparse
would never be used as a stand-alone preprocessor).

however even the emission of the internal symbol name __pragma__ was
broken.
---
 ident-list.h  |  1 -
 pre-process.c | 71 ++++++++++++++++++++++++++++++++---------------------------
 2 files changed, 39 insertions(+), 33 deletions(-)

diff --git a/ident-list.h b/ident-list.h
index 1308757..e2188bc 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -59,7 +59,6 @@ IDENT_RESERVED(__label__);
  * sparse. */
 IDENT(defined);
 IDENT(once);
-__IDENT(pragma_ident, "__pragma__", 0);
 __IDENT(__VA_ARGS___ident, "__VA_ARGS__", 0);
 __IDENT(__LINE___ident, "__LINE__", 0);
 __IDENT(__FILE___ident, "__FILE__", 0);
diff --git a/pre-process.c b/pre-process.c
index 8800dce..751d9ea 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -211,7 +211,7 @@ static void expand_list(struct token **list)
 	}
 }
 
-static void preprocessor_line(struct stream *stream, struct token **line);
+static int preprocessor_line(struct stream *stream, struct token **line);
 
 static struct token *collect_arg(struct token *prev, int vararg, struct position *pos, int count)
 {
@@ -225,9 +225,10 @@ static struct token *collect_arg(struct token *prev, int vararg, struct position
 			if (!next->pos.noexpand) {
 				sparse_error(next->pos,
 					     "directive in argument list");
-				preprocessor_line(stream, p);
-				__free_token(next);	/* Free the '#' token */
-				continue;
+				if(preprocessor_line(stream, p)) {
+					__free_token(next);	/* Free the '#' token */
+					continue;
+				}
 			}
 		}
 		switch (token_type(next)) {
@@ -1808,31 +1809,25 @@ static int handle_split_include(struct stream *stream, struct token **line, stru
 }
 
 /*
- * We replace "#pragma xxx" with "__pragma__" in the token
- * stream. Just as an example.
- *
- * We'll just #define that away for now, but the theory here
- * is that we can use this to insert arbitrary token sequences
- * to turn the pragmas into internal front-end sequences for
- * when we actually start caring about them.
- *
- * So eventually this will turn into some kind of extended
- * __attribute__() like thing, except called __pragma__(xxx).
+ * pragma, unlike all other directives starting with '#' is not
+ * meant for the preprocessor to consume, but it should be
+ * echoed back exactly as in the source code.
+ * the only exception is pragma once, which is targetting the
+ * cpp. preprocessor_line() assumes that any line starting with '#'
+ * can be dropped and manipulates the list to point to the token after
+ * the next newline. however, we need to undo this here if what we get
+ * is not "pragma once. thus we pass the start token pointing to '#'
+ * unlike all other handler function, so we can safely restore the list.
  */
-static int handle_pragma(struct stream *stream, struct token **line, struct token *token)
+static int handle_pragma(struct stream *stream, struct token **line, struct token *start)
 {
-	struct token *next = *line;
-
+	struct token *token = start->next;
 	if (match_ident(token->next, &once_ident) && eof_token(token->next->next)) {
 		stream->once = 1;
 		return 1;
 	}
-	token->ident = &pragma_ident;
-	token->pos.newline = 1;
-	token->pos.whitespace = 1;
-	token->pos.pos = 1;
-	*line = token;
-	token->next = next;
+
+	*line = start;
 	return 0;
 }
 
@@ -1904,14 +1899,15 @@ static void init_preprocessor(void)
 	counter_macro = 0;
 }
 
-static void handle_preprocessor_line(struct stream *stream, struct token **line, struct token *start)
+/* return 1 if the entire preprocessor line was consumed, 0 if it needs to be preserved */
+static int handle_preprocessor_line(struct stream *stream, struct token **line, struct token *start)
 {
 	int (*handler)(struct stream *, struct token **, struct token *);
 	struct token *token = start->next;
-	int is_normal = 1;
+	int is_normal = 1, ret;
 
 	if (eof_token(token))
-		return;
+		return 1;
 
 	if (token_type(token) == TOKEN_IDENT) {
 		struct symbol *sym = lookup_symbol(token->ident, NS_PREPROCESSOR);
@@ -1932,14 +1928,24 @@ static void handle_preprocessor_line(struct stream *stream, struct token **line,
 		if (false_nesting)
 			goto out;
 	}
+
+	ret = 1; /* was the entire line consumed ? */
+
+	/* pragma handler is special */
+	if(handler == handle_pragma) {
+		token = start;
+		ret = 0;
+	}
+
 	if (!handler(stream, line, token))	/* all set */
-		return;
+		return ret;
 
 out:
 	free_preprocessor_line(token);
+	return 1;
 }
 
-static void preprocessor_line(struct stream *stream, struct token **line)
+static int preprocessor_line(struct stream *stream, struct token **line)
 {
 	struct token *start = *line, *next;
 	struct token **tp = &start->next;
@@ -1952,7 +1958,7 @@ static void preprocessor_line(struct stream *stream, struct token **line)
 	}
 	*line = next;
 	*tp = &eof_token_entry;
-	handle_preprocessor_line(stream, line, start);
+	return handle_preprocessor_line(stream, line, start);
 }
 
 static void do_preprocess(struct token **list)
@@ -1964,9 +1970,10 @@ static void do_preprocess(struct token **list)
 
 		if (next->pos.newline && match_op(next, '#')) {
 			if (!next->pos.noexpand) {
-				preprocessor_line(stream, list);
-				__free_token(next);	/* Free the '#' token */
-				continue;
+				if(preprocessor_line(stream, list)) {
+					__free_token(next);	/* Free the '#' token */
+					continue;
+				}
 			}
 		}
 
-- 
2.13.3


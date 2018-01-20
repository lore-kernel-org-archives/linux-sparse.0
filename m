From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC] proper handling of #pragma
Date: Sat, 20 Jan 2018 16:12:56 +0100
Message-ID: <20180120151254.fvijow52q6l546rb@ltop.local>
References: <20180103161419.a43208d5469c43ff36b3d2e1@redchan.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38060 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751324AbeATPM7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 20 Jan 2018 10:12:59 -0500
Received: by mail-wm0-f50.google.com with SMTP id 141so8814284wme.3
        for <linux-sparse@vger.kernel.org>; Sat, 20 Jan 2018 07:12:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180103161419.a43208d5469c43ff36b3d2e1@redchan.it>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: foobar <foobar@redchan.it>
Cc: linux-sparse@vger.kernel.org

On Wed, Jan 03, 2018 at 04:14:19PM +0000, foobar wrote:
> #pragma directives other than #pragma once are not really meant for the preprocessor to consume.
> 
> in preprocessor_only mode, apart from pragma once, they should all be printed to stdout (unless they are under #ifdef that's not taken).
> 
> i've produced a patch that does that, however i'm not really happy about it, since i'm unclear about how to deal
> with the pragma in non-preprocessor mode.
> 
> i suppose the token-stream of the pragma-directive should be converted into some kind of special symbol, which can then be either consumed or ignored when doing the usual iteration over the symbol list.
> but i didn't find an obvious symbol type to assign...

Here under, I've added a draft patch for handling the top level pragmas.
Something must also be added when parsing statements (especially for omp pragmas),
and probably also at declaration level.

From d0d375a35b0803e0ac43eac09123e949a7c890c6 Mon Sep 17 00:00:00 2001
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Sat, 6 Jan 2018 05:24:43 +0100
Subject: [PATCH 1/3] pragma: allow to parse pragmas as toplevel

Just get all the pragma's tokens but for now ignore them
as well as the pragma token itself.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c      | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/parse.c b/parse.c
index e255345fd..5c52ce727 100644
--- a/parse.c
+++ b/parse.c
@@ -76,6 +76,7 @@ static struct token *parse_range_statement(struct token *token, struct statement
 static struct token *parse_asm_statement(struct token *token, struct statement *stmt);
 static struct token *toplevel_asm_declaration(struct token *token, struct symbol_list **list);
 static struct token *parse_static_assert(struct token *token, struct symbol_list **unused);
+static struct token *toplevel_pragma(struct token *token, struct symbol_list *     *list);
 
 typedef struct token *attr_t(struct token *, struct symbol *,
 			     struct decl_state *);
@@ -341,6 +342,10 @@ static struct symbol_op static_assert_op = {
 	.toplevel = parse_static_assert,
 };
 
+static struct symbol_op pragma_op = {
+	.toplevel = toplevel_pragma,
+};
+
 static struct symbol_op packed_op = {
 	.attribute = attribute_packed,
 };
@@ -482,6 +487,8 @@ static struct init_keyword {
 	/* Static assertion */
 	{ "_Static_assert", NS_KEYWORD, .op = &static_assert_op },
 
+	{ "#pragma",	NS_KEYWORD, .op = &pragma_op },
+
 	/* Storage class */
 	{ "auto",	NS_TYPEDEF, .op = &auto_op },
 	{ "register",	NS_TYPEDEF, .op = &register_op },
@@ -2777,6 +2784,16 @@ static struct token *toplevel_asm_declaration(struct token *token, struct symbol
 	return token;
 }
 
+static struct token *toplevel_pragma(struct token *token, struct symbol_list **list)
+{
+	// ignore for now
+	// exact handling here depends on what is reinserted
+	do
+		token = token->next;
+	while (!token->pos.newline);
+
+	return token;
+}
+
 struct token *external_declaration(struct token *token, struct symbol_list **list,
 		validate_decl_t validate_decl)
 {
-- 

For the special symbol, it's not absolutely needed but it may make things a bit neater.

> diff --git a/ident-list.h b/ident-list.h
> index 1308757..e2188bc 100644
> --- a/ident-list.h
> +++ b/ident-list.h
> @@ -59,7 +59,6 @@ IDENT_RESERVED(__label__);
>   * sparse. */
>  IDENT(defined);
>  IDENT(once);
> -__IDENT(pragma_ident, "__pragma__", 0);

You'll want to keep this one or something very similar.

>  __IDENT(__VA_ARGS___ident, "__VA_ARGS__", 0);
>  __IDENT(__LINE___ident, "__LINE__", 0);
>  __IDENT(__FILE___ident, "__FILE__", 0);
> diff --git a/pre-process.c b/pre-process.c
> index 8800dce..751d9ea 100644
> --- a/pre-process.c
> +++ b/pre-process.c
> @@ -211,7 +211,7 @@ static void expand_list(struct token **list)
>  	}
>  }

As I understand it, all your remaining changes are there to go around the fact
that the current code seems to be designed to simply drop everything after
a preprocessor directive.
It's true, but it's also quite easy to simply reinsert what is needed
in the next lines. Something like:

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Sat, 6 Jan 2018 04:34:49 +0100
Subject: [PATCH 2/2] pragma: insert back the pragma's args into the stream

Currently, the pragma directives are replaced with an internal
identifier and all the corresponding arguments are simply dropped.
These identifier are then also dropped by the following call to
expand_one_symbol().

Change this to:
- mark the identifier as noexpand so it's not dropped anymore
- insert back all the arguments into the stream.
---
 pre-process.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index 8800dce53..577f6d0c2 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -1808,16 +1808,11 @@ static int handle_split_include(struct stream *stream, struct token **line, stru
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
+ * Eventually this will turn into some kind of extended
  * __attribute__() like thing, except called __pragma__(xxx).
+ *
+ * For now we just replace '#' 'pragma' xxx... by an internal
+ * identifier.
  */
 static int handle_pragma(struct stream *stream, struct token **line, struct token *token)
 {
@@ -1831,7 +1826,13 @@ static int handle_pragma(struct stream *stream, struct token **line, struct toke
 	token->pos.newline = 1;
 	token->pos.whitespace = 1;
 	token->pos.pos = 1;
+	token->pos.noexpand = 1;
 	*line = token;
+
+	// search for the end-of-line
+	while (!eof_token(token->next))
+		token = token->next;
+	// a special symbol could make this loop unneeded.
+	// and insert the whole line in the stream
 	token->next = next;
 	return 0;
 }
-- 

Cheers,
-- Luc Van Oostenryck

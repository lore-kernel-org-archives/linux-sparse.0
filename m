From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH] Larger buffer size for token concatenation
Date: Wed, 6 Mar 2013 20:22:53 -0800
Message-ID: <CANeU7Qkys+OpHPjZoa7C2Gmma2RozUZxM4DEhOfBGdhg-xT9Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:59974 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754488Ab3CGEWx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 6 Mar 2013 23:22:53 -0500
Received: by mail-oa0-f48.google.com with SMTP id j1so62281oag.21
        for <linux-sparse@vger.kernel.org>; Wed, 06 Mar 2013 20:22:53 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Currently there are a few source file in the kernel can't
parse property due to over run of the concatenation buffer.
They either have a large string concatnation or huge macro
expand.  The TRACE macro is a common one.

Now show_token_sequence and quote_token_sequence is combined
into one function with a bigger buffer. It works for most
of the kernel source except the config_data.h. The kernel
config is about 70K, larger than the string allocator chunk size.
It needs some plumbing work in the allocator before we can
allow bigger string token.

Signed-off-by: Christopher Li <sparse@chrisli.org>
---
 pre-process.c | 48 +++++++++++-------------------------------------
 token.h       |  2 +-
 2 files changed, 12 insertions(+), 38 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index 486fec4..22ddf02 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -338,14 +338,16 @@ static struct token *dup_list(struct token *list)
 	return res;
 }

-static const char *quote_token_sequence(struct token *token)
+static const char *show_token_sequence(struct token *token, int quote)
 {
-	static char buffer[1024];
+	static char buffer[MAX_STRING];
 	char *ptr = buffer;
 	int whitespace = 0;

+	if (!token && !quote)
+		return "<none>";
 	while (!eof_token(token)) {
-		const char *val = quote_token(token);
+		const char *val = quote ? quote_token(token) : show_token(token);
 		int len = strlen(val);

 		if (ptr + whitespace + len >= buffer + sizeof(buffer)) {
@@ -366,7 +368,7 @@ static const char *quote_token_sequence(struct token *token)

 static struct token *stringify(struct token *arg)
 {
-	const char *s = quote_token_sequence(arg);
+	const char *s = show_token_sequence(arg, 1);
 	int size = strlen(s)+1;
 	struct token *token = __alloc_token(0);
 	struct string *string = __alloc_string(size);
@@ -1436,7 +1438,7 @@ static int handle_ifndef(struct stream *stream,
struct token **line, struct toke
 	return preprocessor_if(stream, token, arg);
 }

-static const char *show_token_sequence(struct token *token);
+static const char *show_token_sequence(struct token *token, int quote);

 /*
  * Expression handling for #if and #elif; it differs from normal expansion
@@ -1495,7 +1497,7 @@ static int expression_value(struct token **where)

 	p = constant_expression(*where, &expr);
 	if (!eof_token(p))
-		sparse_error(p->pos, "garbage at end: %s", show_token_sequence(p));
+		sparse_error(p->pos, "garbage at end: %s", show_token_sequence(p, 0));
 	value = get_expression_value(expr);
 	return value != 0;
 }
@@ -1584,43 +1586,15 @@ static int handle_endif(struct stream *stream,
struct token **line, struct token
 	return 1;
 }

-static const char *show_token_sequence(struct token *token)
-{
-	static char buffer[1024];
-	char *ptr = buffer;
-	int whitespace = 0;
-
-	if (!token)
-		return "<none>";
-	while (!eof_token(token)) {
-		const char *val = show_token(token);
-		int len = strlen(val);
-
-		if (ptr + whitespace + len >= buffer + sizeof(buffer)) {
-			sparse_error(token->pos, "too long token expansion");
-			break;
-		}
-
-		if (whitespace)
-			*ptr++ = ' ';
-		memcpy(ptr, val, len);
-		ptr += len;
-		token = token->next;
-		whitespace = token->pos.whitespace;
-	}
-	*ptr = 0;
-	return buffer;
-}
-
 static int handle_warning(struct stream *stream, struct token **line,
struct token *token)
 {
-	warning(token->pos, "%s", show_token_sequence(token->next));
+	warning(token->pos, "%s", show_token_sequence(token->next, 0));
 	return 1;
 }

 static int handle_error(struct stream *stream, struct token **line,
struct token *token)
 {
-	sparse_error(token->pos, "%s", show_token_sequence(token->next));
+	sparse_error(token->pos, "%s", show_token_sequence(token->next, 0));
 	return 1;
 }

@@ -1828,7 +1802,7 @@ static int handle_line(struct stream *stream,
struct token **line, struct token

 static int handle_nondirective(struct stream *stream, struct token
**line, struct token *token)
 {
-	sparse_error(token->pos, "unrecognized preprocessor line '%s'",
show_token_sequence(token));
+	sparse_error(token->pos, "unrecognized preprocessor line '%s'",
show_token_sequence(token, 0));
 	return 1;
 }

diff --git a/token.h b/token.h
index a1218c6..b0d58df 100644
--- a/token.h
+++ b/token.h
@@ -179,7 +179,7 @@ struct token {
 	};
 };

-#define MAX_STRING 4095
+#define MAX_STRING 8191

 static inline struct token *containing_token(struct token **p)
 {
-- 
1.8.1.2

From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 05/15] Remove pre_buffer
Date: Mon, 15 Dec 2008 03:26:28 +0300
Message-ID: <20081215002628.16107.8595.stgit@zaytsev.su>
References: <20081215000849.16107.74332.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:63676 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbYLOARQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 14 Dec 2008 19:17:16 -0500
Received: by mail-bw0-f21.google.com with SMTP id 14so1154922bwz.13
        for <linux-sparse@vger.kernel.org>; Sun, 14 Dec 2008 16:17:15 -0800 (PST)
In-Reply-To: <20081215000849.16107.74332.stgit@zaytsev.su>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Blue Swirl <blauwirbel@gmail.com>, Christopher Li <sparse@chrisli.org>, Christopher Li <spase@chrisli.org>, linux-sparse@vger.kernel.org, David Given <dg@cowlark.com>

From: Christopher Li <spase@chrisli.org>

This patch removes the pre_buffer completely. Instead,
sparse will tokenized the buffer during add_pre_buffer().
Sparse just tracks the beginning and end of pre_buffer.

Reviewed-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Signed-Off-By: Christopher Li <spase@chrisli.org>
---
 lib.c      |   23 ++++++++++++++---------
 token.h    |    2 +-
 tokenize.c |   21 +++++++++++----------
 3 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/lib.c b/lib.c
index 0abcc9a..ea40ce1 100644
--- a/lib.c
+++ b/lib.c
@@ -185,8 +185,8 @@ void die(const char *fmt, ...)
 	exit(1);
 }
 
-static unsigned int pre_buffer_size;
-static char pre_buffer[8192];
+static struct token *pre_buffer_begin = NULL;
+static struct token *pre_buffer_end = NULL;
 
 int Waddress_space = 1;
 int Wbitwise = 0;
@@ -230,14 +230,18 @@ void add_pre_buffer(const char *fmt, ...)
 {
 	va_list args;
 	unsigned int size;
+	struct token *begin, *end;
+	char buffer[4096];
 
 	va_start(args, fmt);
-	size = pre_buffer_size;
-	size += vsnprintf(pre_buffer + size,
-		sizeof(pre_buffer) - size,
-		fmt, args);
-	pre_buffer_size = size;
+	size = vsnprintf(buffer, sizeof(buffer), fmt, args);
 	va_end(args);
+	begin = tokenize_buffer(buffer, size, &end);
+	if (!pre_buffer_begin)
+		pre_buffer_begin = begin;
+	if (pre_buffer_end)
+		pre_buffer_end->next = begin;
+	pre_buffer_end = end;
 }
 
 static char **handle_switch_D(char *arg, char **next)
@@ -819,8 +823,9 @@ static struct symbol_list *sparse_initial(void)
 				 token, includepath);
 
 	// Prepend the initial built-in stream
-	token = tokenize_buffer(pre_buffer, pre_buffer_size, token);
-	return sparse_tokenstream(token);
+	if (token)
+		pre_buffer_end->next = token;
+	return sparse_tokenstream(pre_buffer_begin);
 }
 
 struct symbol_list *sparse_initialize(int argc, char **argv, struct string_list **filelist)
diff --git a/token.h b/token.h
index ba7866d..fda880f 100644
--- a/token.h
+++ b/token.h
@@ -195,7 +195,7 @@ extern const char *show_ident(const struct ident *);
 extern const char *show_string(const struct string *string);
 extern const char *show_token(const struct token *);
 extern struct token * tokenize(const char *, int, struct token *, const char **next_path);
-extern struct token * tokenize_buffer(void *, unsigned long, struct token *);
+extern struct token * tokenize_buffer(void *, unsigned long, struct token **);
 
 extern void show_identifier_stats(void);
 extern struct token *preprocess(struct token *);
diff --git a/tokenize.c b/tokenize.c
index d154882..7c41a56 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -304,7 +304,7 @@ static inline int nextchar(stream_t *stream)
 
 struct token eof_token_entry;
 
-static void mark_eof(stream_t *stream, struct token *end_token)
+static struct token *mark_eof(stream_t *stream)
 {
 	struct token *end;
 
@@ -315,11 +315,10 @@ static void mark_eof(stream_t *stream, struct token *end_token)
 	eof_token_entry.next = &eof_token_entry;
 	eof_token_entry.pos.newline = 1;
 
-	if (!end_token)
-		end_token =  &eof_token_entry;
-	end->next = end_token;
+	end->next =  &eof_token_entry;
 	*stream->tokenlist = end;
 	stream->tokenlist = NULL;
+	return end;
 }
 
 static void add_token(stream_t *stream)
@@ -912,7 +911,7 @@ static struct token *setup_stream(stream_t *stream, int idx, int fd,
 	return begin;
 }
 
-static void tokenize_stream(stream_t *stream, struct token *endtoken)
+static struct token *tokenize_stream(stream_t *stream)
 {
 	int c = nextchar(stream);
 	while (c != EOF) {
@@ -927,22 +926,22 @@ static void tokenize_stream(stream_t *stream, struct token *endtoken)
 		stream->whitespace = 1;
 		c = nextchar(stream);
 	}
-	mark_eof(stream, endtoken);
+	return mark_eof(stream);
 }
 
-struct token * tokenize_buffer(void *buffer, unsigned long size, struct token *endtoken)
+struct token * tokenize_buffer(void *buffer, unsigned long size, struct token **endtoken)
 {
 	stream_t stream;
 	struct token *begin;
 
 	begin = setup_stream(&stream, 0, -1, buffer, size);
-	tokenize_stream(&stream, endtoken);
+	*endtoken = tokenize_stream(&stream);
 	return begin;
 }
 
 struct token * tokenize(const char *name, int fd, struct token *endtoken, const char **next_path)
 {
-	struct token *begin;
+	struct token *begin, *end;
 	stream_t stream;
 	unsigned char buffer[BUFSIZE];
 	int idx;
@@ -954,6 +953,8 @@ struct token * tokenize(const char *name, int fd, struct token *endtoken, const
 	}
 
 	begin = setup_stream(&stream, idx, fd, buffer, 0);
-	tokenize_stream(&stream, endtoken);
+	end = tokenize_stream(&stream);
+	if (endtoken)
+		end->next = endtoken;
 	return begin;
 }


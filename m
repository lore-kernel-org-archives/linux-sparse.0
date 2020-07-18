Return-Path: <SRS0=GL7X=A5=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC7FC433E1
	for <linux-sparse@archiver.kernel.org>; Sat, 18 Jul 2020 23:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32D2221775
	for <linux-sparse@archiver.kernel.org>; Sat, 18 Jul 2020 23:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjIr+y+U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgGRXkY (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 18 Jul 2020 19:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgGRXkX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Jul 2020 19:40:23 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD3DC0619D2
        for <linux-sparse@vger.kernel.org>; Sat, 18 Jul 2020 16:40:23 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id z17so10313184edr.9
        for <linux-sparse@vger.kernel.org>; Sat, 18 Jul 2020 16:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f2SUner/P7+EKpqX4Ez2goMS8mCSu75E2BQXqxWP3eI=;
        b=UjIr+y+U0alxn6MUhL2sV01au6eS8EkgtvXCW1mEV964qJWi2vaBPBcH1estlMLCvF
         Zd3fEXndbRiHqmjQb+eY6txJq5bFAZNzD/0uItyGUUdnon8kWoK6jQsOce4b6gaCJwBf
         /fdtDaBgYriCRK4ZIfeeFsCGg0arqk/vOvEmOjtzdFZFEzMHHm3Nd2QEONaqH+5KEjYA
         Gx7ZhWWDgDULZUvmREr05pzv7bxPJvCIVtJknm+goXrOwL9BhLrjFeKW0EfhpntZ9CP9
         9eQvwoCVLYiE8GZxm5m7DjPSp4wbtwPI6JyQHl4BS/OjsaPrzQzbVx62LT97HFxxWwTY
         iELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f2SUner/P7+EKpqX4Ez2goMS8mCSu75E2BQXqxWP3eI=;
        b=TPALtoKOKjBv5L8dfUPsoMCL8aZt5+Wf4lbezv5J6g4TlBncL4aVSSV7TJPEwrz+20
         rFQKcl2DQdTJdHOsoEk3xec4xYLX6jmiswGw3fZJNhKte/swNMvmPqBcFU9IdBjzMsCD
         QZEQ6X+88jidSgmqTmHQi0Fo8ua72FLElhBkCWZiE3heUE7R1uNTLw1zJSKlYbpzsTQb
         PFzMufRJ29givm8Pbz6Z12MzvvnPDtulo+hQbNRl2pLLBmraygzE6L1K985IiM+tbjAU
         k24LFiYf00afratbRx7pWxfobN7V69LH6Rj4U2xs4FbAVo7/zzvFllU0G4AUf0+nILoR
         Fekg==
X-Gm-Message-State: AOAM530W8VrmE8Z9otRyQ1uoDm9+rnvBgx4JVyc+S+r7UNlOayZ3a6SZ
        kwU5CiaK5NY2yUb+Zhs5x7pVa84S
X-Google-Smtp-Source: ABdhPJzuFVUaj8v/AJ905oPYrYpG5p5ijTqrnWbpAUX/f8uPSaPcYkhSMOHLiDXw0TO+CtsB4C6KgQ==
X-Received: by 2002:a05:6402:1b1c:: with SMTP id by28mr15462604edb.270.1595115621588;
        Sat, 18 Jul 2020 16:40:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:9830:688a:d816:7e62])
        by smtp.gmail.com with ESMTPSA id x19sm12037873eds.43.2020.07.18.16.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 16:40:21 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] add position to struct stream
Date:   Sun, 19 Jul 2020 01:40:11 +0200
Message-Id: <20200718234011.96413-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Now that struct stream contains the parent's stream, it
might as well contains the position so that all information
about the parent is available.

So, drop 'prev_stream' from struct stream and add a struct
position instead and make the few corresponding adjustments.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c         |  2 +-
 pre-process.c | 10 +++++-----
 symbol.c      |  2 +-
 token.h       |  7 ++++---
 tokenize.c    | 13 ++++++++-----
 5 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/lib.c b/lib.c
index dcbbb5b330bd..2b600fee26cc 100644
--- a/lib.c
+++ b/lib.c
@@ -351,7 +351,7 @@ static struct symbol_list *sparse_file(const char *filename)
 	base_filename = filename;
 
 	// Tokenize the input stream
-	token = tokenize(filename, fd, -1, NULL, includepath);
+	token = tokenize(NULL, filename, fd, NULL, includepath);
 	close(fd);
 
 	return sparse_tokenstream(token);
diff --git a/pre-process.c b/pre-process.c
index 6f4bf8979f74..dd7309c729f8 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -894,7 +894,7 @@ static void set_stream_include_path(struct stream *stream)
 #define PATH_MAX 4096	// for Hurd where it's not defined
 #endif
 
-static int try_include(struct position pos, const char *path, const char *filename, int flen, struct token **where, const char **next_path)
+static int try_include(const struct position *pos, const char *path, const char *filename, int flen, struct token **where, const char **next_path)
 {
 	int fd;
 	int plen = strlen(path);
@@ -911,7 +911,7 @@ static int try_include(struct position pos, const char *path, const char *filena
 	fd = open(fullname, O_RDONLY);
 	if (fd >= 0) {
 		char *streamname = xmemdup(fullname, plen + flen);
-		*where = tokenize(streamname, fd, pos.stream, *where, next_path);
+		*where = tokenize(pos, streamname, fd, *where, next_path);
 		close(fd);
 		return 1;
 	}
@@ -923,7 +923,7 @@ static int do_include_path(const char **pptr, struct token **list, struct token
 	const char *path;
 
 	while ((path = *pptr++) != NULL) {
-		if (!try_include(token->pos, path, filename, flen, list, pptr))
+		if (!try_include(&token->pos, path, filename, flen, list, pptr))
 			continue;
 		return 1;
 	}
@@ -966,7 +966,7 @@ static int handle_include_path(struct stream *stream, struct token **list, struc
 
 	/* Absolute path? */
 	if (filename[0] == '/') {
-		if (try_include(token->pos, "", filename, flen, list, includepath))
+		if (try_include(&token->pos, "", filename, flen, list, includepath))
 			return 0;
 		goto out;
 	}
@@ -2091,7 +2091,7 @@ static void create_arglist(struct symbol *sym, int count)
 static void init_preprocessor(void)
 {
 	int i;
-	int stream = init_stream("preprocessor", -1, includepath, -1);
+	int stream = init_stream(NULL, "preprocessor", -1, includepath);
 	static struct {
 		const char *name;
 		int (*handler)(struct stream *, struct token **, struct token *);
diff --git a/symbol.c b/symbol.c
index 2cc9f82df44e..6fcb1b150d27 100644
--- a/symbol.c
+++ b/symbol.c
@@ -776,7 +776,7 @@ struct symbol	zero_int;
 
 void init_symbols(void)
 {
-	int stream = init_stream("builtin", -1, includepath, -1);
+	int stream = init_stream(NULL, "builtin", -1, includepath);
 
 #define __IDENT(n,str,res) \
 	hash_ident(&n)
diff --git a/token.h b/token.h
index 6d2b0b65feba..bccac0e4aba5 100644
--- a/token.h
+++ b/token.h
@@ -49,10 +49,11 @@ enum constantfile {
 extern const char *includepath[];
 
 struct stream {
-	int fd, prev;
+	int fd;
 	const char *name;
 	const char *path;    // input-file path - see set_stream_include_path()
 	const char **next_path;
+	struct position pos; //position of the #include, if any
 
 	/* Use these to check for "already parsed" */
 	enum constantfile constant;
@@ -214,7 +215,7 @@ static inline struct token *containing_token(struct token **p)
 extern struct token eof_token_entry;
 #define eof_token(x) ((x) == &eof_token_entry)
 
-extern int init_stream(const char *, int fd, const char **next_path, int prev_stream);
+extern int init_stream(const struct position *pos, const char *, int fd, const char **next_path);
 extern int stream_prev(int stream);
 extern const char *stream_name(int stream);
 extern struct ident *hash_ident(struct ident *);
@@ -225,7 +226,7 @@ extern const char *show_ident(const struct ident *);
 extern const char *show_string(const struct string *string);
 extern const char *show_token(const struct token *);
 extern const char *quote_token(const struct token *);
-extern struct token * tokenize(const char *, int, int, struct token *, const char **next_path);
+extern struct token * tokenize(const struct position *pos, const char *, int, struct token *, const char **next_path);
 extern struct token * tokenize_buffer(void *, unsigned long, struct token **);
 
 extern void show_identifier_stats(void);
diff --git a/tokenize.c b/tokenize.c
index c5ba6e6bbf5a..d68fbcd8eebd 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -66,7 +66,7 @@ int stream_prev(int stream)
 {
 	if (stream < 0 || stream > input_stream_nr)
 		return -1;
-	return input_streams[stream].prev;
+	return input_streams[stream].pos.stream;
 }
 
 static struct position stream_pos(stream_t *stream)
@@ -307,7 +307,7 @@ int *hash_stream(const char *name)
 	return input_stream_hashes + hash;
 }
 
-int init_stream(const char *name, int fd, const char **next_path, int prev_stream)
+int init_stream(const struct position *pos, const char *name, int fd, const char **next_path)
 {
 	int stream = input_stream_nr, *hash;
 	struct stream *current;
@@ -326,7 +326,10 @@ int init_stream(const char *name, int fd, const char **next_path, int prev_strea
 	current->next_path = next_path;
 	current->path = NULL;
 	current->constant = CONSTANT_FILE_MAYBE;
-	current->prev = prev_stream;
+	if (pos)
+		current->pos = *pos;
+	else
+		current->pos.stream = -1;
 	input_stream_nr = stream+1;
 	hash = hash_stream(name);
 	current->next_stream = *hash;
@@ -1014,14 +1017,14 @@ struct token * tokenize_buffer(void *buffer, unsigned long size, struct token **
 	return begin;
 }
 
-struct token * tokenize(const char *name, int fd, int prev_stream, struct token *endtoken, const char **next_path)
+struct token * tokenize(const struct position *pos, const char *name, int fd, struct token *endtoken, const char **next_path)
 {
 	struct token *begin, *end;
 	stream_t stream;
 	unsigned char buffer[BUFSIZE];
 	int idx;
 
-	idx = init_stream(name, fd, next_path, prev_stream);
+	idx = init_stream(pos, name, fd, next_path);
 	if (idx < 0) {
 		// info(endtoken->pos, "File %s is const", name);
 		return endtoken;

base-commit: e140005c44ef962f5ee2a72735ea727e5db7f7f6
-- 
2.27.0


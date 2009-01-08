From: Hannes Eder <hannes@hanneseder.net>
Subject: [PATCH v3] Add -ftabstop=WIDTH
Date: Thu, 08 Jan 2009 20:18:39 +0100
Message-ID: <20090108191748.10635.63257.stgit@vmbox.hanneseder.net>
References: <70318cbf0901031519w15929f58p68ff62ace683a5b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:43703 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755622AbZAHTSp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 8 Jan 2009 14:18:45 -0500
Received: by bwz14 with SMTP id 14so27836490bwz.13
        for <linux-sparse@vger.kernel.org>; Thu, 08 Jan 2009 11:18:43 -0800 (PST)
In-Reply-To: <70318cbf0901031519w15929f58p68ff62ace683a5b0@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Alexey Zaytsev <alexey.zaytsev@gmail.com>, Junio C Hamano <junio@pobox.com>

Make tokenizer aware of tabstops and add the commandline option:

-ftabstop=WIDTH
    Set the distance between tab stops.  This helps sparse report correct
    column numbers in warnings or errors.  If the value is less than 1 or
    greater than 100, the option is ignored.  The default is 8.

With simplifications suggested by Christopher Li and Junio C Hamano.

Signed-off-by: Hannes Eder <hannes@hanneseder.net>
---

v3: fix a source of a future bugs in option parsing (introduced in v2),
i.e. if an option '-ffoo' is defined then '-ftabstop=foo' whould also
set the option foo.


 lib.c      |   19 +++++++++++++++++++
 sparse.1   |    7 +++++++
 token.h    |    1 +
 tokenize.c |    5 +++--
 4 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/lib.c b/lib.c
index 059ba3b..3185f9f 100644
--- a/lib.c
+++ b/lib.c
@@ -511,6 +511,25 @@ static char **handle_switch_f(char *arg, char **next)
 	int flag = 1;
 
 	arg++;
+
+	if (!strncmp(arg, "tabstop=", 8)) {
+		char *end;
+		unsigned long val;
+		arg += 8;
+
+		if (*arg == '\0')
+			die("error: missing argument to \"-ftabstop=\"");
+
+		/* we silently ignore silly values */
+		val = strtoul(arg, &end, 10);
+		if (*end == '\0' && 1 <= val && val <= 100)
+			tabstop = val;
+
+		return next;
+	}
+
+	/* handle switches w/ arguments above, boolean and only boolean below */
+
 	if (!strncmp(arg, "no-", 3)) {
 		flag = 0;
 		arg += 3;
diff --git a/sparse.1 b/sparse.1
index d242dc7..a9e3397 100644
--- a/sparse.1
+++ b/sparse.1
@@ -287,6 +287,13 @@ However, this behavior can lead to subtle errors.
 
 Sparse does not issue these warnings by default.
 .
+.SH OTHER OPTIONS
+.TP
+.B \-ftabstop=WIDTH
+Set the distance between tab stops.  This helps sparse report correct
+column numbers in warnings or errors.  If the value is less than 1 or
+greater than 100, the option is ignored.  The default is 8.
+.
 .SH SEE ALSO
 .BR cgcc (1)
 .
diff --git a/token.h b/token.h
index ba7866d..44128f2 100644
--- a/token.h
+++ b/token.h
@@ -48,6 +48,7 @@ struct stream {
 
 extern int input_stream_nr;
 extern struct stream *input_streams;
+extern unsigned int tabstop;
 
 struct ident {
 	struct ident *next;	/* Hash chain of identifiers */
diff --git a/tokenize.c b/tokenize.c
index d154882..828a76f 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -25,6 +25,7 @@
 int input_stream_nr = 0;
 struct stream *input_streams;
 static int input_streams_allocated;
+unsigned int tabstop = 8;
 
 #define BUFSIZE (8192)
 
@@ -232,7 +233,7 @@ repeat:
 		goto repeat;
 	}
 
-	stream->pos++;
+	stream->pos += (c == '\t') ? (tabstop - stream->pos % tabstop) : 1;
 
 	if (c == '\n') {
 		stream->line++;
@@ -291,7 +292,7 @@ static inline int nextchar(stream_t *stream)
 	if (offset < stream->size) {
 		int c = stream->buffer[offset++];
 		static const char special[256] = {
-			['\r'] = 1, ['\n'] = 1, ['\\'] = 1
+			['\t'] = 1, ['\r'] = 1, ['\n'] = 1, ['\\'] = 1
 		};
 		if (!special[c]) {
 			stream->offset = offset;


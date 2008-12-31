From: Hannes Eder <hannes@hanneseder.net>
Subject: [PATCH] Add -ftabstop=WIDTH
Date: Wed, 31 Dec 2008 13:41:08 +0100
Message-ID: <20081231124108.10969.28189.stgit@vmbox.hanneseder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:53183 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbYLaMlO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 31 Dec 2008 07:41:14 -0500
Received: by fk-out-0910.google.com with SMTP id 18so2864517fkq.5
        for <linux-sparse@vger.kernel.org>; Wed, 31 Dec 2008 04:41:11 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Make tokenizer aware of tabstops and add the commandline option:

-ftabstop=WIDTH
    Set the distance between tab stops.  This helps sparse report correct
    column numbers in warnings or errors.  If the value is less than 1 or
    greater than 100, the option is ignored.  The default is 8.

Signed-off-by: Hannes Eder <hannes@hanneseder.net>
---
 lib.c      |   31 +++++++++++++++++++++++++++++++
 sparse.1   |    7 +++++++
 token.h    |    1 +
 tokenize.c |    8 ++++++--
 4 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/lib.c b/lib.c
index 059ba3b..80dee3c 100644
--- a/lib.c
+++ b/lib.c
@@ -15,6 +15,8 @@
 #include <string.h>
 #include <unistd.h>
 #include <assert.h>
+#include <limits.h>
+#include <errno.h>
 
 #include <sys/types.h>
 
@@ -511,6 +513,35 @@ static char **handle_switch_f(char *arg, char **next)
 	int flag = 1;
 
 	arg++;
+
+	if (!strncmp (arg, "tabstop=", 8)) {
+		char *end;
+		long val;
+		arg += 8;
+
+		errno = 0;
+		val = strtol(arg, &end, 10);
+
+		if ((errno == ERANGE && (val == LONG_MAX || val == LONG_MIN))
+		    || (errno != 0 && val == 0)) {
+			die("invalid argument for the -ftabstop= option: %s", strerror(errno));
+		}
+
+		if (end == arg) {
+			die("missing argument for the -ftabstop= option");
+		}
+
+		if (*end != '\0') {
+			/* further characters after number */
+			/* we just ignore them */
+		}
+
+		if (1 <= val && val <= 100)
+			tabstop_width = val;
+
+		return next;
+	}
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
index ba7866d..a15ad84 100644
--- a/token.h
+++ b/token.h
@@ -48,6 +48,7 @@ struct stream {
 
 extern int input_stream_nr;
 extern struct stream *input_streams;
+extern int tabstop_width;
 
 struct ident {
 	struct ident *next;	/* Hash chain of identifiers */
diff --git a/tokenize.c b/tokenize.c
index d154882..83cc75e 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -25,6 +25,7 @@
 int input_stream_nr = 0;
 struct stream *input_streams;
 static int input_streams_allocated;
+int tabstop_width = 8;
 
 #define BUFSIZE (8192)
 
@@ -232,7 +233,10 @@ repeat:
 		goto repeat;
 	}
 
-	stream->pos++;
+	if (c == '\t')
+		stream->pos = ((stream->pos - 1) / tabstop_width + 1) * tabstop_width;
+	else
+		stream->pos++;
 
 	if (c == '\n') {
 		stream->line++;
@@ -291,7 +295,7 @@ static inline int nextchar(stream_t *stream)
 	if (offset < stream->size) {
 		int c = stream->buffer[offset++];
 		static const char special[256] = {
-			['\r'] = 1, ['\n'] = 1, ['\\'] = 1
+			['\t'] = 1, ['\r'] = 1, ['\n'] = 1, ['\\'] = 1
 		};
 		if (!special[c]) {
 			stream->offset = offset;


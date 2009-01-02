From: "Hannes Eder" <hannes@hanneseder.net>
Subject: Re: [PATCH v2] Add -ftabstop=WIDTH
Date: Fri, 2 Jan 2009 15:22:28 +0100
Message-ID: <154e089b0901020622u26848778q56d9510e6edc60ff@mail.gmail.com>
References: <20081231124108.10969.28189.stgit@vmbox.hanneseder.net>
	 <70318cbf0812311226gc18b63dld37072c3b7f41719@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:28060 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797AbZABOWb (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 2 Jan 2009 09:22:31 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2273976fgg.17
        for <linux-sparse@vger.kernel.org>; Fri, 02 Jan 2009 06:22:28 -0800 (PST)
In-Reply-To: <70318cbf0812311226gc18b63dld37072c3b7f41719@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Alexey Zaytsev <alexey.zaytsev@gmail.com>

Make tokenizer aware of tabstops and add the commandline option:

-ftabstop=WIDTH
    Set the distance between tab stops.  This helps sparse report correct
    column numbers in warnings or errors.  If the value is less than 1 or
    greater than 100, the option is ignored.  The default is 8.

With simplifications suggested by Christopher Li.

Signed-off-by: Hannes Eder <hannes@hanneseder.net>
---

On Wed, Dec 31, 2008 at 9:26 PM, Christopher Li <sparse@chrisli.org> wrote:
> I took the liberty to simplify the patch a little bit. See the attachment.

I like the part in tokenizer.c, I even simplified it a bit further, to
use a ternary op, and
do not use a variable.

> If there is no objections, I am going to apply the combined patch to
> my repository:

I slightly modified to option parsing part, to be at least as relaxed
as GNU's CPP, where the option is from (see manpage), and to match the
description in sparse.1.

> With simplifications suggested by Christopher Li.

How should I acknowledge your contribution? Is this Ok?

Or shoul I send a patch relative to your patch?


 lib.c      |   17 ++++++++++++++++-
 sparse.1   |    7 +++++++
 token.h    |    1 +
 tokenize.c |    5 +++--
 4 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/lib.c b/lib.c
index 059ba3b..221e7b8 100644
--- a/lib.c
+++ b/lib.c
@@ -15,6 +15,8 @@
 #include <string.h>
 #include <unistd.h>
 #include <assert.h>
+#include <limits.h>
+#include <errno.h>

 #include <sys/types.h>

@@ -511,7 +513,20 @@ static char **handle_switch_f(char *arg, char **next)
 	int flag = 1;

 	arg++;
-	if (!strncmp(arg, "no-", 3)) {
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
+	} else if (!strncmp(arg, "no-", 3)) {
 		flag = 0;
 		arg += 3;
 	}
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

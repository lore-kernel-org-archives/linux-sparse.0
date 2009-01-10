From: Hannes Eder <hannes@hanneseder.net>
Subject: [PATCH] Add -fno-show-column
Date: Sat, 10 Jan 2009 15:19:45 +0100
Message-ID: <20090110141414.7093.82893.stgit@vmbox.hanneseder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:56832 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbZAJOTv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 10 Jan 2009 09:19:51 -0500
Received: by bwz14 with SMTP id 14so30211334bwz.13
        for <linux-sparse@vger.kernel.org>; Sat, 10 Jan 2009 06:19:48 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Do not print column numbers in diagnostic messages.  This may be
necessary if processing the diagnostic messages with a program that
does not understand the column numbers.

The default behaviour of sprase, to print the column numbers, is
left as is by this patch.

Signed-off-by: Hannes Eder <hannes@hanneseder.net>
---

This patch applies to the "-chrisl" tree. It would need a minor
modification in the sparse.1 part to apply to Josh's tree as
well.

 lib.c    |   16 +++++++++++++---
 sparse.1 |    6 ++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/lib.c b/lib.c
index 2b8d21e..ad98343 100644
--- a/lib.c
+++ b/lib.c
@@ -30,6 +30,7 @@
 
 int verbose, optimize, optimize_size, preprocessing;
 int die_if_error = 0;
+static int show_column = 1;
 
 #ifndef __GNUC__
 # define __GNUC__ 2
@@ -90,9 +91,13 @@ static void do_warn(const char *type, struct position pos, const char * fmt, va_
 
 	vsprintf(buffer, fmt, args);	
 	name = stream_name(pos.stream);
-		
-	fprintf(stderr, "%s:%d:%d: %s%s\n",
-		name, pos.line, pos.pos, type, buffer);
+
+	if (show_column)
+		fprintf(stderr, "%s:%d:%d: %s%s\n",
+			name, pos.line, pos.pos, type, buffer);
+	else
+		fprintf(stderr, "%s:%d: %s%s\n",
+			name, pos.line, type, buffer);
 }
 
 static int max_warnings = 100;
@@ -554,6 +559,11 @@ static char **handle_switch_f(char *arg, char **next)
 		arg += 3;
 	}
 	/* handle switch here.. */
+
+	if (!strcmp(arg, "show-column")) {
+		show_column = flag;
+	}
+
 	return next;
 }
 
diff --git a/sparse.1 b/sparse.1
index d7fe444..463ef43 100644
--- a/sparse.1
+++ b/sparse.1
@@ -276,6 +276,12 @@ Set the distance between tab stops.  This helps sparse report correct
 column numbers in warnings or errors.  If the value is less than 1 or
 greater than 100, the option is ignored.  The default is 8.
 .
+.TP
+.B \-fno-show-column
+Do not print column numbers in diagnostic messages.  This may be
+necessary if processing the diagnostic messages with a program that
+does not understand the column numbers.
+.
 .SH SEE ALSO
 .BR cgcc (1)
 .


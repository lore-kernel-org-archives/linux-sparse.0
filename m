From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH] Support #pragma once
Date: Fri, 19 Apr 2013 12:10:38 -0700
Message-ID: <20130419191036.GA8615@jtriplet-mobl1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:39063 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753124Ab3DSTKp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 19 Apr 2013 15:10:45 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Auke Kok <auke-jan.h.kok@intel.com>

"#pragma once" acts like a multiple-inclusion guard affecting the entire file,
without an associated preprocessor symbol.

This allows use of sparse on projects that rely on #pragma once without
also using an ifndef-based multiple-inclusion guard, such as systemd;
without this change, sparse will get into an include loop.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 ident-list.h             | 1 +
 pre-process.c            | 9 +++++++++
 token.h                  | 2 +-
 validation/pragma-once.c | 5 +++++
 4 files changed, 16 insertions(+), 1 deletion(-)
 create mode 100644 validation/pragma-once.c

diff --git a/ident-list.h b/ident-list.h
index e00cd96..e93aae7 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -97,6 +97,7 @@ IDENT(error); IDENT(__error__);
  * itself by name, preventing these tokens from expanding when compiling
  * sparse. */
 IDENT(defined);
+IDENT(once);
 __IDENT(pragma_ident, "__pragma__", 0);
 __IDENT(__VA_ARGS___ident, "__VA_ARGS__", 0);
 __IDENT(__LINE___ident, "__LINE__", 0);
diff --git a/pre-process.c b/pre-process.c
index 486fec4..4d84965 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -743,6 +743,11 @@ static int already_tokenized(const char *path)
 		struct stream *s = input_streams + stream;
 
 		next = s->next_stream;
+		if (s->once) {
+			if (strcmp(path, s->name))
+				continue;
+			return 1;
+		}
 		if (s->constant != CONSTANT_FILE_YES)
 			continue;
 		if (strcmp(path, s->name))
@@ -1809,6 +1814,10 @@ static int handle_pragma(struct stream *stream, struct token **line, struct toke
 {
 	struct token *next = *line;
 
+	if (match_ident(token->next, &once_ident) && eof_token(token->next->next)) {
+		stream->once = 1;
+		return 1;
+	}
 	token->ident = &pragma_ident;
 	token->pos.newline = 1;
 	token->pos.whitespace = 1;
diff --git a/token.h b/token.h
index a1218c6..cfe907b 100644
--- a/token.h
+++ b/token.h
@@ -40,7 +40,7 @@ struct stream {
 
 	/* Use these to check for "already parsed" */
 	enum constantfile constant;
-	int dirty, next_stream;
+	int dirty, next_stream, once;
 	struct ident *protect;
 	struct token *ifndef;
 	struct token *top_if;
diff --git a/validation/pragma-once.c b/validation/pragma-once.c
new file mode 100644
index 0000000..5e8b825
--- /dev/null
+++ b/validation/pragma-once.c
@@ -0,0 +1,5 @@
+#pragma once
+#include "pragma-once.c"
+/*
+ * check-name: #pragma once
+ */
-- 
1.8.2.1


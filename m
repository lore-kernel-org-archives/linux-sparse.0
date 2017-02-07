From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/3] warn on unknown escapes after preprocessing
Date: Tue,  7 Feb 2017 18:45:06 +0100
Message-ID: <20170207174507.22722-3-luc.vanoostenryck@gmail.com>
References: <20170207174507.22722-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35452 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753345AbdBGRwX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Feb 2017 12:52:23 -0500
Received: by mail-wm0-f67.google.com with SMTP id u63so29701906wmu.2
        for <linux-sparse@vger.kernel.org>; Tue, 07 Feb 2017 09:52:23 -0800 (PST)
In-Reply-To: <20170207174507.22722-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Stephen Boyd <sboyd@codeaurora.org>, Al Viro <viro@zeniv.linux.org.uk>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Following the C standards conversion of escaped characters
must be done after preprocessing, just before adjacent
string concatenation. This is what is done but escape
sequence were recognized already at tokenization phase
and a warning is given then when an unknonw escape
sequence was encountered.
But there is no reason to give such warning at this
earlier phase, manly because yhere is no reasons
to warn on things which will be discarded during
the preprocessing.

Fix this by moving the diagnostic of unknown escape
sequence together with the escape conversion.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 char.c                                 | 6 ++++++
 tokenize.c                             | 3 ---
 validation/escapes.c                   | 2 +-
 validation/preprocessor/early-escape.c | 1 -
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/char.c b/char.c
index 9bd3fc0db..e80fceec3 100644
--- a/char.c
+++ b/char.c
@@ -53,7 +53,13 @@ static const char *parse_escape(const char *p, unsigned *val, const char *end, i
 		break;
 	}
 	default:	/* everything else is left as is */
+		warning(pos, "unknown escape sequence: '\\%c'", c);
 		break;
+	case '\\':
+	case '\'':
+	case '"':
+	case '?':
+		break;	/* those are legal, so no warnings */
 	}
 	*val = c & ~((~0U << (bits - 1)) << 1);
 	return p;
diff --git a/tokenize.c b/tokenize.c
index f93ce46ff..632413f0c 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -615,9 +615,6 @@ static int eat_string(int next, stream_t *stream, enum token_type type)
 			want_hex = 0;
 			escape = next == '\\';
 		} else {
-			if (!(cclass[next + 1] & Escape))
-				warning(stream_pos(stream),
-					"Unknown escape '%c'", next);
 			escape = 0;
 			want_hex = next == 'x';
 		}
diff --git a/validation/escapes.c b/validation/escapes.c
index 5f526b9ca..604a37d33 100644
--- a/validation/escapes.c
+++ b/validation/escapes.c
@@ -18,10 +18,10 @@ static char d_oct[3] = "\141";
  * check-name: Character escape sequences
  *
  * check-error-start
-escapes.c:6:26: warning: Unknown escape 'c'
 escapes.c:3:34: warning: hex escape sequence out of range
 escapes.c:3:44: warning: hex escape sequence out of range
 escapes.c:4:18: warning: hex escape sequence out of range
+escapes.c:6:24: warning: unknown escape sequence: '\c'
 escapes.c:6:30: warning: multi-character character constant
 escapes.c:6:39: warning: multi-character character constant
 escapes.c:6:47: warning: hex escape sequence out of range
diff --git a/validation/preprocessor/early-escape.c b/validation/preprocessor/early-escape.c
index c7beba5d8..5ca5e8f42 100644
--- a/validation/preprocessor/early-escape.c
+++ b/validation/preprocessor/early-escape.c
@@ -11,7 +11,6 @@
  *	for a token which is excluded by the preprocessor.
  * check-name: early-escape
  * check-command: sparse -E $file
- * check-known-to-fail
  *
  * check-output-start
 
-- 
2.11.0


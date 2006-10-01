From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH] switch to hash-based get_one_special()
Date: Sun, 1 Oct 2006 19:55:02 +0100
Message-ID: <20061001185502.GA29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:2211 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932198AbWJASzD
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 1 Oct 2006 14:55:03 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-sparse@vger.kernel.org

Subject: [PATCH] switch to hash-based get_one_special()

Weird, but true: the set of C two-character punctuators and
two-symbol prefices of three-character punctuators is
distinguishable by 5-bit hash function (27 out of 32).
Application is obvious - we get much faster get_one_special()
out of that...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

[and now all patches older than a month are gone]

 token.h    |   18 +++++++-------
 tokenize.c |   78 +++++++++++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 75 insertions(+), 21 deletions(-)

diff --git a/token.h b/token.h
index 96b0c41..71ef151 100644
--- a/token.h
+++ b/token.h
@@ -88,13 +88,13 @@ #define COMBINATION_STRINGS {	\
 	"*=",			\
 	"/=",			\
 	"%=",			\
-	"..", "...",		\
-	"<=", "<<", "<<=",	\
-	">=", ">>", ">>=",	\
+	"<=", ">=",		\
 	"==", "!=",		\
 	"&&", "&=",		\
 	"||", "|=",		\
 	"^=", "##",		\
+	"<<", ">>", "..",	\
+	"<<=", ">>=", "..."	\
 	"",			\
 	"<", ">", "<=", ">="	\
 }
@@ -111,14 +111,8 @@ enum special_token {
 	SPECIAL_MUL_ASSIGN,
 	SPECIAL_DIV_ASSIGN,
 	SPECIAL_MOD_ASSIGN,
-	SPECIAL_DOTDOT,
-	SPECIAL_ELLIPSIS,
 	SPECIAL_LTE,
-	SPECIAL_LEFTSHIFT,
-	SPECIAL_SHL_ASSIGN,
 	SPECIAL_GTE,
-	SPECIAL_RIGHTSHIFT,
-	SPECIAL_SHR_ASSIGN,
 	SPECIAL_EQUAL,
 	SPECIAL_NOTEQUAL,
 	SPECIAL_LOGICAL_AND,
@@ -127,6 +121,12 @@ enum special_token {
 	SPECIAL_OR_ASSIGN,
 	SPECIAL_XOR_ASSIGN,
 	SPECIAL_HASHHASH,
+	SPECIAL_LEFTSHIFT,
+	SPECIAL_RIGHTSHIFT,
+	SPECIAL_DOTDOT,
+	SPECIAL_SHL_ASSIGN,
+	SPECIAL_SHR_ASSIGN,
+	SPECIAL_ELLIPSIS,
 	SPECIAL_ARG_SEPARATOR,
 	SPECIAL_UNSIGNED_LT,
 	SPECIAL_UNSIGNED_GT,
diff --git a/tokenize.c b/tokenize.c
index 497da13..67f5a67 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -283,7 +283,7 @@ got_eof:
  *  Slow path (including the logics with line-splicing and EOF sanity
  *  checks) is in nextchar_slow().
  */
-static int nextchar(stream_t *stream)
+static inline int nextchar(stream_t *stream)
 {
 	int offset = stream->offset;
 
@@ -615,12 +615,68 @@ unsigned char combinations[][3] = COMBIN
 
 #define NR_COMBINATIONS (SPECIAL_ARG_SEPARATOR - SPECIAL_BASE)
 
+/* hash function for two-character punctuators - all give unique values */
+#define special_hash(c0, c1) (((c0*8+c1*2)+((c0*8+c1*2)>>5))&31)
+
+/*
+ * note that we won't get false positives - special_hash(0,0) is 0 and
+ * entry 0 is filled (by +=), so all the missing ones are OK.
+ */
+static unsigned char hash_results[32][2] = {
+#define RES(c0, c1) [special_hash(c0, c1)] = {c0, c1}
+	RES('+', '='), /* 00 */
+	RES('/', '='), /* 01 */
+	RES('^', '='), /* 05 */
+	RES('&', '&'), /* 07 */
+	RES('#', '#'), /* 08 */
+	RES('<', '<'), /* 0a */
+	RES('<', '='), /* 0c */
+	RES('!', '='), /* 0e */
+	RES('%', '='), /* 0f */
+	RES('-', '-'), /* 10 */
+	RES('-', '='), /* 11 */
+	RES('-', '>'), /* 13 */
+	RES('=', '='), /* 15 */
+	RES('&', '='), /* 17 */
+	RES('*', '='), /* 18 */
+	RES('.', '.'), /* 1a */
+	RES('+', '+'), /* 1b */
+	RES('|', '='), /* 1c */
+	RES('>', '='), /* 1d */
+	RES('|', '|'), /* 1e */
+	RES('>', '>')  /* 1f */
+#undef RES
+};
+static int code[32] = {
+#define CODE(c0, c1, value) [special_hash(c0, c1)] = value
+	CODE('+', '=', SPECIAL_ADD_ASSIGN), /* 00 */
+	CODE('/', '=', SPECIAL_DIV_ASSIGN), /* 01 */
+	CODE('^', '=', SPECIAL_XOR_ASSIGN), /* 05 */
+	CODE('&', '&', SPECIAL_LOGICAL_AND), /* 07 */
+	CODE('#', '#', SPECIAL_HASHHASH), /* 08 */
+	CODE('<', '<', SPECIAL_LEFTSHIFT), /* 0a */
+	CODE('<', '=', SPECIAL_LTE), /* 0c */
+	CODE('!', '=', SPECIAL_NOTEQUAL), /* 0e */
+	CODE('%', '=', SPECIAL_MOD_ASSIGN), /* 0f */
+	CODE('-', '-', SPECIAL_DECREMENT), /* 10 */
+	CODE('-', '=', SPECIAL_SUB_ASSIGN), /* 11 */
+	CODE('-', '>', SPECIAL_DEREFERENCE), /* 13 */
+	CODE('=', '=', SPECIAL_EQUAL), /* 15 */
+	CODE('&', '=', SPECIAL_AND_ASSIGN), /* 17 */
+	CODE('*', '=', SPECIAL_MUL_ASSIGN), /* 18 */
+	CODE('.', '.', SPECIAL_DOTDOT), /* 1a */
+	CODE('+', '+', SPECIAL_INCREMENT), /* 1b */
+	CODE('|', '=', SPECIAL_OR_ASSIGN), /* 1c */
+	CODE('>', '=', SPECIAL_GTE), /* 1d */
+	CODE('|', '|', SPECIAL_LOGICAL_OR), /* 1e */
+	CODE('>', '>', SPECIAL_RIGHTSHIFT)  /* 1f */
+#undef CODE
+};
+
 static int get_one_special(int c, stream_t *stream)
 {
 	struct token *token;
-	unsigned char c1, c2, c3;
 	int next, value, i;
-	unsigned char *comb;
 
 	next = nextchar(stream);
 
@@ -648,17 +704,15 @@ static int get_one_special(int c, stream
 	 */
 	value = c;
 	if (cclass[next + 1] & ValidSecond) {
-		comb = combinations[0];
-		c1 = c; c2 = next; c3 = 0;
-		for (i = 0; i < NR_COMBINATIONS; i++) {
-			if (comb[0] == c1 && comb[1] == c2 && comb[2] == c3) {
-				value = i + SPECIAL_BASE;
+		i = special_hash(c, next);
+		if (hash_results[i][0] == c && hash_results[i][1] == next) {
+			value = code[i];
+			next = nextchar(stream);
+			if (value >= SPECIAL_LEFTSHIFT &&
+			    next == "==."[value - SPECIAL_LEFTSHIFT]) {
+				value += 3;
 				next = nextchar(stream);
-				if (c3)
-					break;
-				c3 = next;
 			}
-			comb += 3;
 		}
 	}
 
-- 
1.4.2.GIT

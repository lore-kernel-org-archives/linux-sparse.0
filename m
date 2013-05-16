From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 1/3] char.c: Fix parsing of escapes
Date: Thu, 16 May 2013 20:41:24 +0100
Message-ID: <51953664.1040300@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:51498 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753266Ab3EPTyN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 16 May 2013 15:54:13 -0400
Received: from smtp.demon.co.uk (unknown [127.0.0.1])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id CD53D400907
	for <linux-sparse@vger.kernel.org>; Thu, 16 May 2013 20:47:29 +0100 (BST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


When parsing a string or character constant, the parse_escape()
function returns a pointer to the character at which to resume
parsing. However, in the case of an hex or octal escape, it was
returning a one-past-the-end pointer. Thus, a string like:

    char str[3] = "\x61\x62\x63";

was being parsed as:

    '\x61', 'x', '6', '2', '\x63'

which, in turn, provokes an 'too long initializer' warning.

Also, fix an off-by-one error in get_char_constant() when setting
the 'end' pointer for a TOKEN_CHAR or TOKEN_WIDE_CHAR. Despite the
name, the string->length of the token is actually the size of the
allocated memory (ie len+1), so we need to compensate by using
'token->string->length - 1'.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 char.c               |  9 ++++++---
 validation/escapes.c | 12 ++++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/char.c b/char.c
index 6a46a11..08ca223 100644
--- a/char.c
+++ b/char.c
@@ -27,9 +27,10 @@ static const char *parse_escape(const char *p, unsigned *val, const char *end, i
 	case 'x': {
 		unsigned mask = -(1U << (bits - 4));
 		for (c = 0; p < end; c = (c << 4) + d) {
-			d = hexval(*p++);
+			d = hexval(*p);
 			if (d > 16)
 				break;
+			p++;
 			if (c & mask) {
 				warning(pos,
 					"hex escape sequence out of range");
@@ -42,8 +43,10 @@ static const char *parse_escape(const char *p, unsigned *val, const char *end, i
 		if (p + 2 < end)
 			end = p + 2;
 		c -= '0';
-		while (p < end && (d = *p++ - '0') < 8)
+		while (p < end && (d = *p - '0') < 8) {
 			c = (c << 3) + d;
+			p++;
+		}
 		if ((c & 0400) && bits < 9)
 			warning(pos,
 				"octal escape sequence out of range");
@@ -65,7 +68,7 @@ void get_char_constant(struct token *token, unsigned long long *val)
 	case TOKEN_CHAR:
 	case TOKEN_WIDE_CHAR:
 		p = token->string->data;
-		end = p + token->string->length;
+		end = p + token->string->length - 1;
 		break;
 	case TOKEN_CHAR_EMBEDDED_0 ... TOKEN_CHAR_EMBEDDED_3:
 		end = p + type - TOKEN_CHAR;
diff --git a/validation/escapes.c b/validation/escapes.c
index 4a1b030..5f526b9 100644
--- a/validation/escapes.c
+++ b/validation/escapes.c
@@ -4,6 +4,16 @@ static int e[] = { '\'', '\"', '\?', '\\',
 static char *s = "\'\"\?\\ \a\b\f\n\r\t\v \377\xcafe";
 
 static int bad_e[] = { '\c', '\0123', '\789', '\xdefg' };
+
+static char a_hex[3] = "\x61\x62\x63";
+static char b_hex[3] = "\x61\x62\x63\x64";
+static char c_hex[3] = "\x61\x62";
+static char d_hex[3] = "\x61";
+
+static char a_oct[3] = "\141\142\143";
+static char b_oct[3] = "\141\142\143\144";
+static char c_oct[3] = "\141\142";
+static char d_oct[3] = "\141";
 /*
  * check-name: Character escape sequences
  *
@@ -16,5 +26,7 @@ escapes.c:6:30: warning: multi-character character constant
 escapes.c:6:39: warning: multi-character character constant
 escapes.c:6:47: warning: hex escape sequence out of range
 escapes.c:6:47: warning: multi-character character constant
+escapes.c:9:24: warning: too long initializer-string for array of char
+escapes.c:14:24: warning: too long initializer-string for array of char
  * check-error-end
  */
-- 
1.8.2


From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 0/3] v0.4.5-rc1
Date: Thu, 16 May 2013 20:39:04 +0100
Message-ID: <519535D8.3090808@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:46728 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753110Ab3EPTyM (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 16 May 2013 15:54:12 -0400
Received: from smtp.demon.co.uk (unknown [127.0.0.1])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id F011018C6AC
	for <linux-sparse@vger.kernel.org>; Thu, 16 May 2013 20:47:27 +0100 (BST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


Hi Christopher,

I recently updated my sparse repo(s) to give v0.4.5-rc1 a try.

I found two regressions. The first is addressed by the first
patch (char.c: Fix parsing of escapes). I have not fixed the
second regression yet. It Looks like this:

  $ cat -n test1.c
       1
       2  static unsigned int fred(int a, char *b) __attribute ((pure));
       3  static unsigned int __attribute ((pure)) fred(int a, char *b)
       4  {
       5          return (unsigned)(a + ((b) ? 1 : 0));
       6  }
       7
  $ ./sparse test1.c
  test1.c:3:42: error: symbol 'fred' redeclared with different type (originally de
  clared at test1.c:2) - different modifiers
  $

Essentially, the __attribute((pure)) placed before the function
prototype gets 'forgotten'; move the __attribute to match the
declaration, after the function prototype, and everything is fine.

The commit which introduced the regression was commit 8376ab09
("sparse: Fix __builtin_safe_p for pure and const functions",
22-08-2011). Since the pure attribute was simply ignored before
this patch, I guess you could argue that it is not responsible
for this failure to apply the attribute placed in this position.

The second patch just fixes some new build warnings.

The final patch was just lying around in my Linux repo! Several
of the patches I had on Linux are no longer required (e.g I also
have a patch to add --version).

For example, I had a patch to fix the problem which was addressed
by commit fbc8230fa8 ("Larger buffer size for token concatenation",
05-03-2013). However, I have added my patch below (it's an *old*
patch based on v0.4.3 which will most likely not apply anymore),
since commit fbc8230fa8 can not handle my test-case. (It *does*
fix the actual problem on the git source). If nothing else, it
demonstrates another solution to the problem. Just FYI, my test
looks like:

  $ cat -n too-long-test.c
       1  #include <assert.h>
       2
       3  #define some(x) x x x x x x x x x x
       4  #define more(x) some(x) some(x) some(x) some(x) some(x)
       5  #define time(x) more(x) more(x) more(x) more(x) more(x)
       6  #define now(x)  time(x) time(x) time(x) time(x) time(x)
       7
       8  int main(int argc, char **argv)
       9  {
      10          assert(now("is the winter of our discontent"));
      11  }
  $ cgcc -no-compile too-long-test.c
  too-long-test.c:10:9: warning: trying to concatenate 38750-character string (409
  5 bytes max)
  $

I have 3 sparse repos on Linux, cygwin and MinGW, each with some
local patches. In particular, I ported sparse to MinGW four years
ago, but have yet to "tidy-up" and post them here! :-D (I note that
someone asked about sparse on MinGW a few months ago on the list).

HTH

Ramsay Jones (3):
  char.c: Fix parsing of escapes
  Makefile: Fix some macro redefinition warnings
  symbol.c: Set correct size of array from parenthesized string
    initializer

 Makefile                      |  2 +-
 char.c                        |  9 ++++++---
 symbol.c                      | 10 ++++++++++
 validation/escapes.c          | 12 ++++++++++++
 validation/init-char-array1.c | 25 +++++++++++++++++++++++++
 5 files changed, 54 insertions(+), 4 deletions(-)
 create mode 100644 validation/init-char-array1.c

ATB,
Ramsay Jones

-- >8 --
From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Date: Fri, 22 Apr 2011 19:58:40 +0100
Subject: [PATCH] Fix token overflow

When compiling with optimisation enabled, the glibc headers
define some "mega" macros for some string handling routines.
This causes string overflow problems on git when compiling
several instances of expressions like:
    assert(strcmp(...));

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 pre-process.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index 656acaa..c05ca9f 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -340,15 +340,60 @@ static struct token *dup_list(struct token *list)
 	return res;
 }
 
+static int token_sequence_length(struct token *token)
+{
+	int length = 0, whitespace = 0;
+
+	if (!token)
+		return 0;
+	while (!eof_token(token)) {
+		const char *val = show_token(token);
+		int len = strlen(val);
+
+		if (whitespace)
+			length++;
+		length += len;
+		token = token->next;
+		whitespace = token->pos.whitespace;
+	}
+	return length;
+}
+
+static void token_sequence_to_string(struct string *s, struct token *token)
+{
+	char *ptr = s->data;
+	int whitespace = 0;
+
+	*ptr = 0;
+	if (!token)
+		return;
+	while (!eof_token(token)) {
+		const char *val = show_token(token);
+		int len = strlen(val);
+
+		if (ptr + whitespace + len >= s->data + s->length) {
+			sparse_error(token->pos, "too long token expansion");
+			break;
+		}
+
+		if (whitespace)
+			*ptr++ = ' ';
+		memcpy(ptr, val, len);
+		ptr += len;
+		token = token->next;
+		whitespace = token->pos.whitespace;
+	}
+	*ptr = 0;
+}
+
 static struct token *stringify(struct token *arg)
 {
-	const char *s = show_token_sequence(arg);
-	int size = strlen(s)+1;
+	int size = token_sequence_length(arg)+1;
 	struct token *token = __alloc_token(0);
 	struct string *string = __alloc_string(size);
 
-	memcpy(string->data, s, size);
 	string->length = size;
+	token_sequence_to_string(string, arg);
 	token->pos = arg->pos;
 	token_type(token) = TOKEN_STRING;
 	token->string = string;
-- 
1.8.2


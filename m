From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2] Avoid reusing string buffer when doing string expansion
Date: Wed, 4 Feb 2015 03:01:30 +0100
Message-ID: <20150204020059.GA7069@macpro.local>
References: <87y4ojhq2f.fsf@rasmusvillemoes.dk>
 <20150131012339.GA3460@macpro.local>
 <87386mvcxh.fsf@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:45301 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbbBDCBf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 3 Feb 2015 21:01:35 -0500
Received: by mail-we0-f169.google.com with SMTP id u56so48284122wes.0
        for <linux-sparse@vger.kernel.org>; Tue, 03 Feb 2015 18:01:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87386mvcxh.fsf@rasmusvillemoes.dk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>


In get_string_constant(), the code tried to reuse the storage for the string
but only if the expansion of the string was not bigger than its unexpanded form.
But this string can be shared with other expressions and reusing the buffer will
result in later corruption

A minimal exemple would be something like:
const char a[] = BACKSLASH;
const char b[] = BACKSLASH;

The expansion for 'a' will correctly produce the two-char string consisting
of a backslash char followed by a null char.
But then the expansion of 'b' will expand this once more,
producing the expansion of "\0": the two-char string: { '\0', '\0' }.

The fix is to not reuse the storage for the string if any king of expansion
have been done.

Reported-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 char.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/char.c b/char.c
index 08ca2230..2e21bb77 100644
--- a/char.c
+++ b/char.c
@@ -123,11 +123,15 @@ struct token *get_string_constant(struct token *token, struct expression *expr)
 		len = MAX_STRING;
 	}
 
-	if (len >= string->length)	/* can't cannibalize */
+	/* The input string can be shared with other expression and so
+	 * its storage can't be reused if any kind of expansion have been done on it.
+	 */
+	if ((len != string->length) || memcmp(buffer, string->data, len)) {
 		string = __alloc_string(len+1);
-	string->length = len+1;
-	memcpy(string->data, buffer, len);
-	string->data[len] = '\0';
+		string->length = len+1;
+		memcpy(string->data, buffer, len);
+		string->data[len] = '\0';
+	}
 	expr->string = string;
 	expr->wide = is_wide;
 	return token;
-- 
2.2.0



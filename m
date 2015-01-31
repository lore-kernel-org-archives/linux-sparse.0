From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] Avoid reuse of string buffer when concatening adjacent
 string litterals
Date: Sat, 31 Jan 2015 02:23:40 +0100
Message-ID: <20150131012339.GA3460@macpro.local>
References: <87y4ojhq2f.fsf@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:46681 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbbAaBXo (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 30 Jan 2015 20:23:44 -0500
Received: by mail-wg0-f54.google.com with SMTP id b13so29641937wgh.13
        for <linux-sparse@vger.kernel.org>; Fri, 30 Jan 2015 17:23:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87y4ojhq2f.fsf@rasmusvillemoes.dk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

In get_string_constant(), the code tried to reuse the storage for the string
but only if the expansion of the string was not bigger than its unexpanded form.
But this fail when the string constant is a sequence of adjacent string litterals
(each being possibly shared, used elsewhere, isolated or in another order).
The minimal exemple would be something like this:

#define P "\001"
const char a[] = P "a";
const char b[] = P "b";

The expansion for 'a' will produce a string which is smaller than
the unexpanded "\001" (2 instead of 4).
By trying to reuse the storage, all further occurrence of "\001"
(probably only from the same 'origin', here the macro P) will then be replaced by "\001a".

The fix is thus to not try to reuse the storage for the string if it consit of
several adjacent litterals.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 char.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/char.c b/char.c
index 08ca2230..ce1a0700 100644
--- a/char.c
+++ b/char.c
@@ -93,6 +93,7 @@ struct token *get_string_constant(struct token *token, struct expression *expr)
 	static char buffer[MAX_STRING];
 	int len = 0;
 	int bits;
+	int parts = 0;
 
 	while (!done) {
 		switch (token_type(next)) {
@@ -117,13 +118,14 @@ struct token *get_string_constant(struct token *token, struct expression *expr)
 			len++;
 		}
 		token = token->next;
+		parts++;
 	}
 	if (len > MAX_STRING) {
 		warning(token->pos, "trying to concatenate %d-character string (%d bytes max)", len, MAX_STRING);
 		len = MAX_STRING;
 	}
 
-	if (len >= string->length)	/* can't cannibalize */
+	if (len >= string->length || parts > 1)	/* safe to reuse the string buffer */
 		string = __alloc_string(len+1);
 	string->length = len+1;
 	memcpy(string->data, buffer, len);
-- 
2.2.2



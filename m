Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761673D7D61
	for <linux-sparse@vger.kernel.org>; Tue, 31 Mar 2026 08:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774944242; cv=none; b=azRtm4BxMCpYkVTu2i/u3MVHTsahRudyvXJBqUwRM3NNC2Ny7yvXyKz18BAflTXIYL0pK9Y0ISbBys3/HEWAS1MED7ZkuXWiZiy6VpvFIU8BYKSMPZ0iqZcXrqOPDXGjkNY1LI/D0wZzuEGPzzsQkY8USth3Rxi9DNJ+kE2Wvtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774944242; c=relaxed/simple;
	bh=eXWRxxBspcsZ+U5/2mDwtzbdmavr6J+WugbEGf1ulU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5MOWVvYIK7MsXq4Q7Re7dryrLswY8ZRjCo2/sHXQTk2kLIlxDdtn1Dv71T2o9Q+EckuPBRD7/2V2SGDYsCOoix7HPNSd7dlK/c49rzHh54cC4YSpKV3W6/qKsR+AOaRfToaXsCsCg9cknDBvbD5Y2VONXMBL6k5RNsHCYaQx9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vujAbGvl; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vujAbGvl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=UHH5FCP9qDkl0RTK0B3jH6XQ2fWTySsFU4oeMtGzkvM=; b=vujAbGvl+XhDtJpdc+SRuSFQPW
	o86/qvo6fP7G+vea4505OfcFQk47MBIOqBmqml/C1Bfm3BWmSrY/AXcuEFslIx5WNdxpbnElCJwo2
	JfGjXnPS8QD0XIYpJQ7hOCJc1EVLk01y644kZguHcNhB+24cd0bjpRbZbGJjKy3sS2QrGo0PYlrSc
	3h7YuatBz2n/IiKdYCRNYU4b7bgPpnQykAObvdcFCIRXXil5es6fdE46+q4dXIGnD0JiQKutTvPoQ
	Gj+ehGs7mHPfeuRzv2snzhLKWQck/m9FWI6+GONZJ2VWCAQ3ImhIdK8Uca0NbLlnjXUiQmRcAshWT
	J/LcXOTA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w7U8I-00000005meQ-3t39;
	Tue, 31 Mar 2026 08:07:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-sparse@vger.kernel.org
Cc: chriscli@google.com,
	torvalds@linux-foundation.org,
	zxh@xh-zhang.com,
	ben.dooks@codethink.co.uk,
	dan.carpenter@linaro.org,
	rf@opensource.cirrus.com
Subject: [PATCH 6/6] try to get whitespaces right
Date: Tue, 31 Mar 2026 09:07:29 +0100
Message-ID: <20260331080729.1378613-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331080729.1378613-1-viro@zeniv.linux.org.uk>
References: <20260331080631.GA1328137@ZenIV>
 <20260331080729.1378613-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Preprocessor started as a text filter - it took a stream of characters
and produced a stream of characters, with the output fed to compiler.
Semantics had been not _quite_ as bad as with Bourne shell, but it
had been full of dark corners all the same.

By C99 times it had been replaced with something far better defined.
Now it operates on stream of tokens, and the output stream is _not_
fed through the tokenizer again.  Operations are defined in terms of
manipulations with that stream of tokens, which avoids a lot of
headache.

Unfortunately, it's not exactly a stream of tokens - it's a stream of
tokens and whitespaces.  Which is where the things get interesting.
When the standard says "replace the tokens from <here> to <there> with
the sequence of tokens obtained by <this>", the general understanding
is that
	* whatever whitespaces might've been between <here> and <there>
are removed
	* any whitespaces prior to <here> and past <there> remain as-is
	* any whitespaces between the tokens of the sequence we are
told to substitute go into the the result.
What's not agreed upon is what should be done to possible leading or
trailing whitespaces in the sequence.

In a lot of cases it doesn't matter - subsequent phases care only about
tokens.  Moreover, '#' operator (which does care about whitespaces) is
explicitly required to trim any leading and trailing whitespace.  However,
there are cases where it is observable and different implementations
yield different results.

Currently sparse is prone to losing whitespace in many situations
where it definitely shouldn't.  This commit attempts to fix that;
semantics I'm going for matches what clang is doing, namely "trim the
leading and trailing whitespace off the sequence being substituted".
I would consider doing what gcc does (and it does diverge from clang in
some cases), but... it's full of interesting corner cases and downright
broken around combining __VA_OPT__() with ##.  When/if they decide what
to do with that...

What this commit does is
	* don't lose ->pos.{newline,whitespace} deposited on TOKEN_UNTAINT
tokens; when scan_next() finds and skips those, have it collect their
->pos.{whitespace,newline}.  If we are not at the end of the list and
eventually get to a normal token, add the collected flags to it. Turns
out that the comment in expand() had been too pessimistic - it's _not_
terribly costly, provided that the slow case of scan_next() is uninlined.

	* have substitute() keep better track of pending whitespace.
We still don't want to copy ## or placemaker tokens into the growing
replacement list, only to go over it again and exclude those, etc.,
so we build the list incrementally; ## awaiting the second argument is
still represented as part of state.  It's just that in addition to
	<tokens>
	<tokens>[placemaker]
	<tokens>[##]
we need to distinguish
	<tokens>[whitespace][placemaker]
	<tokens>[whitespace][placemaker][##]
as possible states.

Note: gcc code generation for bitfields really, really stinks.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 pre-process.c                     | 102 ++++++++++++++++++------------
 validation/preprocessor/va_opt.c  |  23 ++++---
 validation/preprocessor/va_opt2.c |   2 +-
 3 files changed, 75 insertions(+), 52 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index a368b9ed..8a30bf3e 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -91,17 +91,6 @@ static const char **dirafter_includepath = includepath + 3;
 		stream->protect = NULL;	\
 	} while(0)
 
-static struct token *alloc_token(struct position *pos)
-{
-	struct token *token = __alloc_token(0);
-
-	token->pos.stream = pos->stream;
-	token->pos.line = pos->line;
-	token->pos.pos = pos->pos;
-	token->pos.whitespace = 1;
-	return token;
-}
-
 /* Expand symbol 'sym' at '*list' */
 static int expand(struct token **, struct symbol *);
 
@@ -231,19 +220,34 @@ static inline int expand_one_symbol(struct token **list)
 	}
 }
 
-static inline struct token *scan_next(struct token **where)
+static struct token *skip_untaints(struct token *token)
 {
-	struct token *token = *where;
-	if (token_type(token) != TOKEN_UNTAINT)
-		return token;
+	bool whitespace = false, newline = false;
 	do {
 		token->ident->tainted = 0;
+		if (token->pos.whitespace)
+			whitespace = true;
+		if (token->pos.newline)
+			newline = true;
 		token = token->next;
 	} while (token_type(token) == TOKEN_UNTAINT);
-	*where = token;
+	if (token_type(token) != TOKEN_EOF) {
+		if (whitespace)
+			token->pos.whitespace = 1;
+		if (newline)
+			token->pos.newline = 1;
+	}
 	return token;
 }
 
+static inline struct token *scan_next(struct token **where)
+{
+	struct token *token = *where;
+	if (token_type(token) != TOKEN_UNTAINT)
+		return token;
+	return *where = skip_untaints(token);
+}
+
 static void expand_list(struct token **list)
 {
 	struct token *next;
@@ -678,10 +682,29 @@ static bool skip_va_opt(struct arg *args, struct ident *expanding)
 	return eof_token(arg);
 }
 
+enum expansion_state {
+	Placemarker,	//	<tokens>Empty
+	Normal,		//	<tokens>
+	Concat,		//	<tokens> ##
+	Whitespace,	//	<tokens> Empty
+	Concat_White	//	<tokens> Empty ##
+};
+
+static enum expansion_state add_empty(enum expansion_state state,
+				      const struct token *body)
+{
+	if (state < Concat)
+		return !body->pos.whitespace ? Placemarker : Whitespace;
+	else if (state == Concat)
+		return Normal;
+	else
+		return Whitespace;
+}
+
 static struct token **substitute(struct token **list, const struct token *body, struct arg *args)
 {
 	struct position *base_pos = &(*list)->pos;
-	enum {Normal, Placeholder, Concat} state = Normal, saved_state = Normal;
+	enum expansion_state state = Normal, saved_state = Normal;
 	struct ident *expanding = (*list)->ident;
 	struct token **saved_list = NULL, *va_opt_list;
 
@@ -698,10 +721,7 @@ static struct token **substitute(struct token **list, const struct token *body,
 
 			arg = do_argument(body, args, expanding);
 			if (!arg || eof_token(arg)) {
-				if (state == Concat)
-					state = Normal;
-				else
-					state = Placeholder;
+				state = add_empty(state, body);
 				continue;
 			}
 			if (state == Concat && merge(containing_token(list), arg)) {
@@ -721,16 +741,18 @@ static struct token **substitute(struct token **list, const struct token *body,
 				list = copy(list, arg);
 			if (inserted_at) {
 				struct token *p = *inserted_at;
-				p->pos.whitespace = body->pos.whitespace;
+				p->pos.whitespace = 0;
 				p->pos.newline = 0;
+				if (body->pos.whitespace || state > Concat)
+					p->pos.whitespace = 1;
 			}
 			state = Normal;
 			continue;
 		} else if (token_type(body) == TOKEN_CONCAT) {
-			if (state == Placeholder)
-				state = Normal;
-			else
-				state = Concat;
+			state++;	// Placemarker -> Normal
+					// Normal -> Concat
+					// White -> Concat_White
+					// impossible in Concat and Concat_White
 			continue;
 		} else if (token_type(body) == TOKEN_GNU_KLUDGE) {
 			const struct token *t = body;
@@ -744,10 +766,7 @@ static struct token **substitute(struct token **list, const struct token *body,
 			 * otherwise we act as if the kludge didn't exist.
 			 */
 			if (handle_kludge(&body, args)) {
-				if (state == Concat)
-					state = Normal;
-				else
-					state = Placeholder;
+				state = add_empty(state, body);
 				continue;
 			}
 			added = dup_token(t, base_pos);
@@ -756,10 +775,7 @@ static struct token **substitute(struct token **list, const struct token *body,
 			// entering va_opt?
 			if (!is_end_va_opt(body)) {
 				if (skip_va_opt(args, expanding)) {
-					if (state == Concat)
-						state = Normal;
-					else
-						state = Placeholder;
+					state = add_empty(state, body);
 					continue;
 				}
 				body = body->va_opt_linkage;
@@ -801,6 +817,8 @@ static struct token **substitute(struct token **list, const struct token *body,
 		if (state != Concat || !merge(containing_token(list), added)) {
 			*list = added;
 			list = &added->next;
+			if (state > Concat)
+				added->pos.whitespace = 1;
 		}
 		state = Normal;
 	}
@@ -826,12 +844,14 @@ static int expand(struct token **list, struct symbol *sym)
 	tail = substitute(list, expansion, args);
 	/*
 	 * Note that it won't be eof - at least TOKEN_UNTAINT will be there.
-	 * We still can lose the newline flag if the sucker expands to nothing,
-	 * but the price of dealing with that is probably too high (we'd need
-	 * to collect the flags during scan_next())
+	 * We still can lose the whitespace information in the end of list,
+	 * but that's deliberate - we match clang behaviour here.
 	 */
-	(*list)->pos.newline = token->pos.newline;
-	(*list)->pos.whitespace = token->pos.whitespace;
+	struct position pos = (*list)->pos;
+	struct position pos2 = token->pos;
+	pos.newline = pos2.newline;
+	pos.whitespace = pos2.whitespace;
+	(*list)->pos = pos;
 	*tail = next;
 
 	return 0;
@@ -1537,8 +1557,8 @@ static struct token *parse_expansion(struct token *expansion, struct ident *name
 				p->argnum |= 1 << ARGNUM_CONSUME_EXPAND;
 		}
 	}
-	token = alloc_token(&expansion->pos);
-	token_type(token) = TOKEN_UNTAINT;
+	token = __alloc_token(0);
+	token->pos = (struct position){.type = TOKEN_UNTAINT};
 	token->ident = name;
 	token->next = &eof_token_entry;
 	*tail = token;
diff --git a/validation/preprocessor/va_opt.c b/validation/preprocessor/va_opt.c
index 4fa38794..afb5b007 100644
--- a/validation/preprocessor/va_opt.c
+++ b/validation/preprocessor/va_opt.c
@@ -1,3 +1,6 @@
+// Examples from C23 draft.  Several are slightly incorrect - the common
+// problem is that whitespace before a vanishing __VA_OPT__ (or an empty
+// argument, for that matter) does *not* disappear.
 #define LPAREN() (
 #define G(Q) 42
 #define F(R, X, ...) __VA_OPT__(G R X) )
@@ -9,12 +12,12 @@ int x = F(LPAREN(), 0, <:-); // replaced by int x = 42;
 #define SDEF(sname, ...) S sname __VA_OPT__(= { __VA_ARGS__ })
 #define EMP
 F(a, b, c) // replaced by f(0, a, b, c)
-F() // replaced by f(0)
-F(EMP) // replaced by f(0)
+F() // replaced by f(0)				[wrong]
+F(EMP) // replaced by f(0)			[wrong]
 G(a, b, c) // replaced by f(0, a, b, c)
-G(a, ) // replaced by f(0, a)
-G(a) // replaced by f(0, a)
-SDEF(foo); // replaced by S foo;
+G(a, ) // replaced by f(0, a)			[wrong]
+G(a) // replaced by f(0, a)			[wrong]
+SDEF(foo); // replaced by S foo;		[wrong]
 SDEF(bar, 1, 2); // replaced by S bar = { 1, 2 };
 // may not appear at the beginning of a replacement
 // list (6.10.5.3)
@@ -36,12 +39,12 @@ H5C(H5A()) // replaced by ab
 
 int x = 42;
 f(0 , a, b, c)
-f(0)
-f(0)
+f(0 )
+f(0 )
 f(0, a , b, c)
-f(0, a)
-f(0, a)
-S foo;
+f(0, a )
+f(0, a )
+S foo ;
 S bar = { 1, 2 };
 ab, c, d
 ""
diff --git a/validation/preprocessor/va_opt2.c b/validation/preprocessor/va_opt2.c
index 5523301e..0828ce58 100644
--- a/validation/preprocessor/va_opt2.c
+++ b/validation/preprocessor/va_opt2.c
@@ -23,7 +23,7 @@ F(E(_))
 
 1 AB(_)
 [_ 1]
-[]
+[ ]
 AE(_) R
 AE(_) R
  * check-output-end
-- 
2.47.3


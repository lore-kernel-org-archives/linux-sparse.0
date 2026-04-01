Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E05F38E118
	for <linux-sparse@vger.kernel.org>; Wed,  1 Apr 2026 10:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775039753; cv=none; b=Id7hhsZXqOazZhGoMPxD9iwD4pg8SE1fLI3tDoKtZqp7Fh60jvQaLzAgNPt+/3NV2AmFIHnxcO/R/EO9bdPt2fIwdTFuwCQzie9tLpSPUsafw6WGU1kcwlQ8tbVGociH6DUJ7JQ8Nqe2irRFGZbbGsfxCdoq9kG8IM2GoLml5cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775039753; c=relaxed/simple;
	bh=I8nR6E5fnUAMBsph+rrWThG5AjgffkXXESjyfaltd9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npkNIQeuCg1rZNzvjWyyBUFbbh3r+JoxT+57HCi9ZCnXeOrutlkZbnLx0r3JnO7zO3kFj2TU3fUZji/UgkBVHVk6j/Wu96d/Rg+bvsotzSoHPGzvdGOCtYeEqfPMxwuTdOnnmTIWOnXPi4BbECbtPw0Mrv+0S8fOedv+//rHcVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cq4/PIAt; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cq4/PIAt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BKTrxkmses8xk6DQlFkXkJeMN3UNLU+pRW5GKpBz028=; b=cq4/PIAtpHvyTohDaDXLxFbLAk
	IuXYZdh/RShEuNQwJY4N83EC+z/Xjt3NsVbDuEHR7AUaNrIlmChvzZKzkp1avX8OzRMbOs6jtCbSi
	Bg+uRwm85Hid7YrqXKPLBG9J72yYzjHlMaQtQ4PNeroB9nqpjbjMVbJ9Jx5CsczGNnbyPLKBceXvj
	wqryU8olkASgjPQZQn17uhOcBf3N4zy3fPg0PIzTntBsvevpBy8u5XIuBBMkP1Kn/diWqNmT5mG5P
	s2XJj7CVghL67iqvpBdjMhFo/lNuIZku47LrIDs6nMTzmwJk9Qk9yylLuy4IDuWzM4z8olXwUUtz2
	WRjUR7sw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w7syl-00000002sR5-3nAV;
	Wed, 01 Apr 2026 10:39:20 +0000
Date: Wed, 1 Apr 2026 11:39:19 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: chriscli@google.com
Cc: linux-sparse@vger.kernel.org, dan.carpenter@linaro.org,
	ben.dooks@codethink.co.uk, rf@opensource.cirrus.com,
	torvalds@linux-foundation.org, Eric Zhang <zxh@xh-zhang.com>
Subject: Re: [RFC PATCH] pre-process: add __VA_OPT__ support
Message-ID: <20260401103919.GA2063236@ZenIV>
References: <20260225072731.GA3093958@ZenIV>
 <20260225081413.2480484-1-zxh@xh-zhang.com>
 <20260225221851.GE1762976@ZenIV>
 <20260226072945.GA4104757@ZenIV>
 <20260316065622.GA607739@ZenIV>
 <20260331080631.GA1328137@ZenIV>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331080631.GA1328137@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Mar 31, 2026 at 09:06:31AM +0100, Al Viro wrote:
> On Mon, Mar 16, 2026 at 06:56:22AM +0000, Al Viro wrote:
> 
> ... and here's are the whitespace fixes and a bunch of optimizations; I
> really wonder if we ought to simply switch to uint64_t for struct position
> contents and go for several helpers for accessing individual parts.
> Code generation with clang is reasonable, but gcc is bloody awful -
> I'm sick and tired of fighting it all the time ;-/ Anyway, I've spent
> way too much time in that rabbit hole.  I've a few more sitting in the
> local queue (tokenizer optimizations, mostly), but that's a separate
> story and I'd rather leave that for later.

Sigh...  whitespace handling (6/6) had been too convoluted and ended
up with breakage due to a missed case.  Untangled, fixed and force-pushed
into the same branch, with more testcases and hopefully better explanation
of what was's going on with the machinery in substitute().  Ends up being
faster, at that...  Replacement for #6 below; comments and review would be
welcome.

[PATCH 6/6] try to get whitespaces right
    
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
The tricky part is the logics related to placemarkers and concatenation;
see the comments in front of substitute() for details.
    
Note: gcc code generation for bitfields really, really stinks.
    
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/pre-process.c b/pre-process.c
index a368b9ed..dab8768a 100644
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
@@ -678,10 +682,94 @@ static bool skip_va_opt(struct arg *args, struct ident *expanding)
 	return eof_token(arg);
 }
 
+/*
+ * substitute(): handle macro expansion.
+ * Notionally we should
+ *	Copy the body of macro
+ *	Replace the occurrences of parameters within it with actual
+ *	arguments, placemarker tokens, stringified forms of actual
+ *	arguments or with results of their full expansion, depending
+ *	upon the context.
+ *	Remove all occurrences of ## operator, merging the tokens that
+ *	precede and follow those.  Placemarkers are neutral elements
+ *	wrt merge.
+ *	Remove all remaining placemarkers.
+ * Naive implementation would involve walking the list many times, which
+ * is obviously costly.  Fortunately, it's possible to do everything in
+ * one pass.  Since we have already determined the context for all
+ * occurrences of parameters back when we processed the defintion, the
+ * only tricky part is in handling of ## operators.  We evaluate them
+ * in left-to-right order (standard explicitly leaves implementation free
+ * to choose any, but left-to-right is the usual variant).  Another
+ * unspecified thing is what to do if body of a macro has two adjacent
+ * ## operators without any tokens in between; interpretation varies
+ * between the implementations and we follow gcc here - treat those as
+ * a single ##.
+ * That results in a nice property - if all ## to the left of some token
+ * have already been processed, all tokens to the left of that one are
+ * not going to be affected by the remaining ##.  Moreover, any placemarkers
+ * to the left of that token are going to quietly disappear.
+ * That allows to build the list iteratively, with the part already
+ * constructed containing neither parameters, nor ##, nor placemarkers -
+ * only whitespace and normal tokens.  Consider the next tokens (possibly
+ * with preceding whitespace) coming from body or from argument substitution.
+ * Since concatenation consumes adjacent whitespace, we can ignore the
+ * preceding whitespace for ##.
+ * Let's denote whitespace as w, placemarker as P, ## as C and any other
+ * token as T. Rules:
+ *	<list> T:	<list, T>
+ *	<list> wT:	<list, wT>
+ *	<list> C T	merge T into the last token of list
+ *	<list> C wT	merge T into the last token of list (## consumes whitespace)
+ *	<list> C P	<list> (placemarker is the right neutral)
+ *	<list> C wP	<list>
+ *	<list> P T:	<list, T> (we can remove that placemarker immediately)
+ *	<list> P wT:	<list, wT>
+ *	<list> P P:	<list> P
+ *	<list> P wP:	<list> wP
+ *	<list> wP T:	<list, wT>
+ *	<list> wP wT:	<list, wT>
+ *	<list> wP P:	<list> wP
+ *	<list> wP wP:	<list> wP
+ *	<list> P C T:	<list, T> (placemarker is the left neutral)
+ *	<list> P C wT:	<list, T>
+ *	<list> P C P:	<list> P
+ *	<list> P C wP:	<list> P
+ *	<list> wP C T:	<list, wT>
+ *	<list> wP C wT:	<list, wT>
+ *	<list> wP C P:	<list> wP
+ *	<list> wP C wP:	<list> wP
+ * In other words, the next step is determined by at most 3 following tokens.
+ * So we need to keep track of at most two tokens past the already constructed
+ * list and there are only 6 possible sequences for those:
+ *	empty, P, wP, C, P C, wP C.
+ * In other words, we need to keep track of the already built list + already
+ * observed suffix from the set above.  Rules above are easy to express in
+ * those terms - incoming token is either acted upon or added to the suffix.
+ * Note that suffix always matches w?P?( C)?, so it can be encoded as a simple
+ * bitmap; we get better code generation that way.
+ */
+enum {
+	Placemarker = 1,
+	Whitespace = 2,
+	Concat = 4,
+};
+
+static int placemarker(int suffix, const struct token *body)
+{
+	// if suffix ends with C, strip it off
+	if (suffix & Concat)
+		return suffix & ~Concat;
+	// ... otherwise add P or wP to the suffix
+	if (body->pos.whitespace)
+		suffix |= Whitespace;
+	return suffix | Placemarker;
+}
+
 static struct token **substitute(struct token **list, const struct token *body, struct arg *args)
 {
 	struct position *base_pos = &(*list)->pos;
-	enum {Normal, Placeholder, Concat} state = Normal, saved_state = Normal;
+	int suffix = 0, saved_suffix = 0;
 	struct ident *expanding = (*list)->ident;
 	struct token **saved_list = NULL, *va_opt_list;
 
@@ -698,17 +786,14 @@ static struct token **substitute(struct token **list, const struct token *body,
 
 			arg = do_argument(body, args, expanding);
 			if (!arg || eof_token(arg)) {
-				if (state == Concat)
-					state = Normal;
-				else
-					state = Placeholder;
+				suffix = placemarker(suffix, body);
 				continue;
 			}
-			if (state == Concat && merge(containing_token(list), arg)) {
+			if (suffix == Concat && merge(containing_token(list), arg)) {
 				arg = arg->next;
 				if (eof_token(arg)) {
 					// merged the sole token in
-					state = Normal;
+					suffix = 0;
 					continue;
 				}
 				inserted_at = NULL;
@@ -721,16 +806,16 @@ static struct token **substitute(struct token **list, const struct token *body,
 				list = copy(list, arg);
 			if (inserted_at) {
 				struct token *p = *inserted_at;
-				p->pos.whitespace = body->pos.whitespace;
+				p->pos.whitespace = 0;
 				p->pos.newline = 0;
+				if (suffix & Whitespace ||
+				    (!(suffix & Concat) && body->pos.whitespace))
+					p->pos.whitespace = 1;
 			}
-			state = Normal;
+			suffix = 0;
 			continue;
 		} else if (token_type(body) == TOKEN_CONCAT) {
-			if (state == Placeholder)
-				state = Normal;
-			else
-				state = Concat;
+			suffix |= Concat;
 			continue;
 		} else if (token_type(body) == TOKEN_GNU_KLUDGE) {
 			const struct token *t = body;
@@ -744,10 +829,7 @@ static struct token **substitute(struct token **list, const struct token *body,
 			 * otherwise we act as if the kludge didn't exist.
 			 */
 			if (handle_kludge(&body, args)) {
-				if (state == Concat)
-					state = Normal;
-				else
-					state = Placeholder;
+				suffix = placemarker(suffix, body);
 				continue;
 			}
 			added = dup_token(t, base_pos);
@@ -756,10 +838,7 @@ static struct token **substitute(struct token **list, const struct token *body,
 			// entering va_opt?
 			if (!is_end_va_opt(body)) {
 				if (skip_va_opt(args, expanding)) {
-					if (state == Concat)
-						state = Normal;
-					else
-						state = Placeholder;
+					suffix = placemarker(suffix, body);
 					continue;
 				}
 				body = body->va_opt_linkage;
@@ -777,12 +856,12 @@ static struct token **substitute(struct token **list, const struct token *body,
 				added = stringify(va_opt_list);
 			}
 			list = saved_list;
-			state = saved_state;
+			suffix = saved_suffix;
 		} else if (token_type(body) == TOKEN_VA_OPT_STR) {
 			// entering #va_opt
 			if (!skip_va_opt(args, expanding)) {
-				saved_state = state;
-				state = Normal;
+				saved_suffix = suffix;
+				suffix = 0;
 				saved_list = list;
 				list = &va_opt_list;
 				body = body->va_opt_linkage;
@@ -798,11 +877,15 @@ static struct token **substitute(struct token **list, const struct token *body,
 		 * if we got to doing real concatenation, we already have
 		 * added something into the list, so containing_token() is OK.
 		 */
-		if (state != Concat || !merge(containing_token(list), added)) {
+		if (suffix != Concat || !merge(containing_token(list), added)) {
 			*list = added;
 			list = &added->next;
+			if (suffix & Concat)
+				added->pos.whitespace = 0;
+			if (suffix & Whitespace)
+				added->pos.whitespace = 1;
 		}
-		state = Normal;
+		suffix = 0;
 	}
 	return list;
 }
@@ -826,12 +909,14 @@ static int expand(struct token **list, struct symbol *sym)
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
@@ -1537,8 +1622,8 @@ static struct token *parse_expansion(struct token *expansion, struct ident *name
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
diff --git a/validation/preprocessor/va_opt-concat.c b/validation/preprocessor/va_opt-concat.c
new file mode 100644
index 00000000..f39cabad
--- /dev/null
+++ b/validation/preprocessor/va_opt-concat.c
@@ -0,0 +1,24 @@
+// gcc bug; left concat works there, right concat doesn't
+// it's not just gcc -E spewing garbage - try to compile that
+// with gcc -c and watch the fireworks.
+#define E
+#define F1 E 1 E
+#define A(X,...) 1##__VA_OPT__(X)
+int m1 = A(F1,...);	// left concatenation - int m1 = 11;
+
+#define F2 sizeof m E
+#define B(X,...) __VA_OPT__(X)##1
+int m2 = B(F2,_);	// right concatenation - int m2 = sizeof m1;
+/*
+ * check-name: __VA_OPT__ interplay with ##
+ * check-command: sparse -E $file
+ *
+ * check-output-start
+
+int m1 = 11;
+int m2 = sizeof m1;
+ * check-output-end
+ *
+ * check-error-start
+ * check-error-end
+ */
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
diff --git a/validation/preprocessor/whitespace.c b/validation/preprocessor/whitespace.c
new file mode 100644
index 00000000..27bbea14
--- /dev/null
+++ b/validation/preprocessor/whitespace.c
@@ -0,0 +1,100 @@
+#define S(X) #X
+
+#if notyet
+#define EXPECT(X,Y) _Static_assert(__builtin_strcmp(S(X),Y) == 0, \
+				 #X " => " S(X) ", " Y "expected");
+#define Y(M) EXPECT(M(,]),"[ ]")
+#define N(M) EXPECT(M(,]),"[]")
+#else
+
+// We ought to add __builtin_strcmp() support to constant expressions;
+// what's more, "foo"[0] should also be recognized as one...
+// Sloppy length check for now...
+
+#define __Y(X) _Static_assert(__builtin_strlen(S(X)) == 3, \
+				#X " => " S(X) ", [ ] expected");
+#define Y(M) __Y(M(,]))
+#define __N(X) _Static_assert(__builtin_strlen(S(X)) == 2, \
+				#X " => " S(X) ", [] expected");
+#define N(M) __N(M(,]))
+#endif
+
+#define T1(X,R) []	// T
+#define A1(X,R) [R	// A
+N(T1)
+N(A1)
+#define T2(X,R) [ ]	// wT
+#define A2(X,R) [ R	// wA
+Y(T2)
+Y(A2)
+#define T3(X,Y) [X]	// P T
+#define A3(X,Y,...) [__VA_OPT__()Y	// P A
+// this one takes a bit more work to arrange - we can't just
+// put two argument names without a whitespace in between.
+// Fortunately, __VA_OPT__() generates a placemarker as well...
+
+N(T3)
+N(A3)
+
+#define T4(X,Y) [X ]	// P wT
+#define A4(X,Y) [X Y	// P wA
+Y(T4)
+Y(A4)
+
+#define T5(X,Y) [ X]	// wP T
+#define A5(X,Y,...) [ __VA_OPT__()Y	// wP A
+Y(T5)
+Y(A5)
+
+#define T6(X,Y) [ X ]	// wP wT
+#define A6(X,Y) [ X Y	// wP wA
+Y(T6)
+Y(A6)
+
+#define T7(X,Y,...) [__VA_OPT__()__VA_OPT__()]	// P P T
+#define A7(X,Y,...) [__VA_OPT__()__VA_OPT__()Y	// P P A
+N(T7)
+N(A7)
+
+#define T8(X,Y,...) [__VA_OPT__() __VA_OPT__()]	// P wP T
+#define A8(X,Y,...) [__VA_OPT__() __VA_OPT__()Y	// P wP A
+Y(T8)
+Y(A8)
+
+#define T9(X,Y,...) [ __VA_OPT__()__VA_OPT__()]	// wP P T
+#define A9(X,Y,...) [ __VA_OPT__()__VA_OPT__()Y	// wP P A
+Y(T9)
+Y(A9)
+
+#define T10(X,Y,...) [ __VA_OPT__() __VA_OPT__()]	// wP wP T
+#define A10(X,Y,...) [ __VA_OPT__() __VA_OPT__()Y	// wP wP A
+Y(T10)
+Y(A10)
+
+#define T11(X,Y) [X ##]	// P C T
+#define A11(X,Y) [X ##Y	// P C A
+N(T11)
+N(A11)
+
+#define T12(X,Y) [X ## ]	// P C wT
+#define A12(X,Y) [X ## Y	// P C wA
+N(T12)
+N(A12)
+
+#define T13(X,Y) [ X ##]	// wP C T
+#define A13(X,Y) [ X ##Y	// wP C A
+Y(T13)
+Y(A13)
+
+#define T14(X,Y) [ X ## ]	// wP C wT
+#define A14(X,Y) [ X ## Y	// wP C wA
+Y(T14)
+Y(A14)
+/*
+ * check-name: whitespace handling
+ * check-description: verify that substitute() gets the whitespace right
+ * check-command: sparse $file
+ *
+ * check-output-start
+ * check-output-end
+ */

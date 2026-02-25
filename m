Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF3A2D5410
	for <linux-sparse@vger.kernel.org>; Wed, 25 Feb 2026 05:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771997401; cv=none; b=BqlN8eGhm2LAdB1/fcncJ9Frczw4CWjsZqWDffBlDWoZZuRu/pT+XFlPfCwArUZhlKIeW5/7e3ulhmdhheYKuSiHs4KVNcgU7eh5K+f/DurewN5Aben6WToosjcw+wiJO/d9AVLgC6MuJshl/FKTL6CMUm8os71D/WeGe4Piap8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771997401; c=relaxed/simple;
	bh=nPAoScBBw1JyFYRAPhQRDh/rLuygERZHFgKRwn2Pxn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JqCAcml9dK0f9qPZyVXklCFrVGp0NI7358mkdHhjTws4xY+eCNv/aKGumfs9IVpZJC6c22lFHNcwdH0Fm1bjO7uLCs7M2B+PvPFWNwkxCXoVungorx7XmL00LERYWlz/a6qXUDMjMLr7Q9221SmI26a76+vX9tHVRkiLwk4V+cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xh-zhang.com; spf=none smtp.mailfrom=xh-zhang.com; dkim=pass (2048-bit key) header.d=xh-zhang-com.20230601.gappssmtp.com header.i=@xh-zhang-com.20230601.gappssmtp.com header.b=BOi1xIx2; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xh-zhang.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xh-zhang.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xh-zhang-com.20230601.gappssmtp.com header.i=@xh-zhang-com.20230601.gappssmtp.com header.b="BOi1xIx2"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ba90683995so233618eec.1
        for <linux-sparse@vger.kernel.org>; Tue, 24 Feb 2026 21:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xh-zhang-com.20230601.gappssmtp.com; s=20230601; t=1771997399; x=1772602199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2gruoiWevxw0RMKJFpU2jh91f1e8W9j+OHFneTJ9QU=;
        b=BOi1xIx2jo1vmiKEgJVKk0fDlduQo/MCt5d0z4w9WE9bB6gpILqpHeSGUuYXWXXy67
         7uIpQgdXc0ISaCT4OnoMR6KL+NG7d04y7w6cCIyP5cAgT1MOSk/1loLJDT75TPsmP31m
         pE0BJfPFKdv6BwbZZzkXB95iZnOZm3UL6bIASqD/uFMrm0O832sEvKx7tbZBoHl0YqHi
         FQJ3WWSWxgf7RDO+gbPaCPO6TFnTS8M5BCDJ7u/2hbYZCE5Ey2gCzMsTBlGu1bJxhIId
         Xl6t6Ds9fIU2+mt3boFQ865Vje9gyLKOWaaqpMJiGr49jpxeVtf46P/jDPLtEWPlJaDh
         NvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771997399; x=1772602199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x2gruoiWevxw0RMKJFpU2jh91f1e8W9j+OHFneTJ9QU=;
        b=kXIMVtiJD6lv2KxLEYIL0c1Rp5mpES0Dn+Z3tOc+jldFrB+sc71c4PAPpNjpbnfQxh
         OxhHWMcgrgs8FaZ6m8/15h6fhiwajlmO/wBdlvAMJtQ1xsP5Rso39KBlhUDm2/xF2leo
         vny0L/DwytqBTZpxObZiiEjVUGbIr86It+gLcmnDx6HGkKWGzUn9ctFnL87x948dWPAQ
         AAHa/EoB7d+i9A54IGaImtnghKdbgff1OB7MZuUUcsNYm9OKHUrFwOXlropfeICmmcx+
         XXfeocn1xP4ZZbqeyIhDzJ3P85MM2c6N3RN1oy0Wd5awrykzR32kd/xAgQy/psMbF8vq
         YCtA==
X-Gm-Message-State: AOJu0YyiqQYKY+T7BMr64ht22ZRaVGQNUUpSnaSlb5TrSTLKKe7NTju2
	ohGd4WU6DvPv1qkb4bC6Qg1L6MwalsaBUEkFgfmOBpO+MpPruQCiQPoNvNyr+88HZjysqaVlryj
	EAtD5s7Q=
X-Gm-Gg: ATEYQzxM8y2mpOJ9lyULtwZzrnhVZl5nN0GLywFa2X2n2tfII92mQK3jMMYEnofhNbI
	KwW/Qvtbslq7V8N2PcaUdW4b0IVsefpUgpHlK75u4OMhH5fjaCO9EofG3/x8Q0kKV1y5XCMr629
	D56OtzbY9462INxmKoAxG1avJ4B+DpjGOEGhqUHuaebY7vnF+UK/INBfBvWergQu+9KbKlcmPKF
	+ZBLuRuxPKKde6DVhMCpG/Qrk/iP942/8Ef+N7HZs7AQldFCSR+PYYMI4YXt0ogfwtOaFH4tk+R
	W9ZTYzCOgDP4P5k+uxX4H/hMrrwxIoL0kcD2ljMmJmdS8rTHeM0LZjjkZpUdaW3JdWDYFgDPPiP
	YJyNGuTTCq65kkCO0u0q5yDOeMB36H9SrI9rvKapoGYAo8O5m+XWhA5NoSmELjN+lQdV7kk2fwa
	T9EOc6Ob4e1eVHfYpfQvUHYjspBTMq
X-Received: by 2002:a05:7300:bc86:b0:2a4:3593:ccba with SMTP id 5a478bee46e88-2bdbc1e659cmr1003224eec.1.1771997398872;
        Tue, 24 Feb 2026 21:29:58 -0800 (PST)
Received: from Hurricpc.localdomain ([73.223.85.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dbe77absm8124512eec.19.2026.02.24.21.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 21:29:58 -0800 (PST)
From: Eric Zhang <zxh@xh-zhang.com>
To: linux-sparse@vger.kernel.org
Cc: dan.carpenter@linaro.org,
	viro@zeniv.linux.org.uk,
	chriscli@google.com,
	ben.dooks@codethink.co.uk,
	rf@opensource.cirrus.com,
	torvalds@linux-foundation.org,
	Eric Zhang <zxh@xh-zhang.com>
Subject: [RFC PATCH] pre-process: add __VA_OPT__ support
Date: Tue, 24 Feb 2026 21:29:50 -0800
Message-ID: <20260225052950.2444262-1-zxh@xh-zhang.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225033639.GA2924820@ZenIV>
References: <20260225033639.GA2924820@ZenIV>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add __VA_OPT__ support (C23 6.10.5) including some tests.

At expansion time, substitute() checks whether the variadic
argument is empty: if so, skip the region between the markers;
otherwise, process the enclosed tokens normally.

Signed-off-by: Eric Zhang <zxh@xh-zhang.com>
---
Discussed this with Chris during lunch yesterday and got curious
about the problem, so made a few attempts.  Introducing
TOKEN_VA_OPT_START/END feels a bit like an anti-pattern, but I
couldn't find a cleaner way to handle it without new token types.
Happy to hear suggestions.

Note: this does not handle the __COUNTER__ side-effect issue
(arguments under __VA_OPT__ are expanded even when discarded).

 ident-list.h                            |   1 +
 pre-process.c                           | 132 ++++++++++++++++++++++++
 token.h                                 |   2 +
 tokenize.c                              |   6 ++
 validation/preprocessor/va-opt-errors.c |  38 +++++++
 validation/preprocessor/va-opt.c        |  66 ++++++++++++
 6 files changed, 245 insertions(+)
 create mode 100644 validation/preprocessor/va-opt-errors.c
 create mode 100644 validation/preprocessor/va-opt.c

diff --git a/ident-list.h b/ident-list.h
index 3c08e8ca..556d4050 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -65,6 +65,7 @@ IDENT(c_generic_selections);
 IDENT(c_static_assert);
 __IDENT(pragma_ident, "__pragma__", 0);
 __IDENT(__VA_ARGS___ident, "__VA_ARGS__", 0);
+__IDENT(__VA_OPT___ident, "__VA_OPT__", 0);
 __IDENT(__func___ident, "__func__", 0);
 __IDENT(__FUNCTION___ident, "__FUNCTION__", 0);
 __IDENT(__PRETTY_FUNCTION___ident, "__PRETTY_FUNCTION__", 0);
diff --git a/pre-process.c b/pre-process.c
index 4e322855..ec4c7b98 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -643,13 +643,37 @@ static struct token **substitute(struct token **list, const struct token *body,
 	struct position *base_pos = &(*list)->pos;
 	int *count;
 	enum {Normal, Placeholder, Concat} state = Normal;
+	int va_opt_ws = 0;
 
 	for (; !eof_token(body); body = body->next) {
 		struct token *added, *arg;
 		struct token **tail;
 		const struct token *t;
+		struct arg *va;
+		int is_empty;
 
 		switch (token_type(body)) {
+		case TOKEN_VA_OPT_START:
+			va = &args[body->argnum];
+			is_empty = (!va->arg || eof_token(va->arg)) &&
+				   (!va->expanded || eof_token(va->expanded));
+			if (is_empty) {
+				/* empty varargs: skip to end marker */
+				while (token_type(body) != TOKEN_VA_OPT_END)
+					body = body->next;
+				if (state == Concat)
+					state = Normal;
+				else
+					state = Placeholder;
+				continue;
+			}
+			/* non-empty: skip marker, transfer whitespace */
+			va_opt_ws = body->pos.whitespace;
+			continue;
+
+		case TOKEN_VA_OPT_END:
+			continue;
+
 		case TOKEN_GNU_KLUDGE:
 			/*
 			 * GNU kludge: if we had <comma>##<vararg>, behaviour
@@ -728,6 +752,10 @@ static struct token **substitute(struct token **list, const struct token *body,
 			if (tail != &added->next)
 				list = tail;
 		} else {
+			if (va_opt_ws) {
+				added->pos.whitespace = va_opt_ws;
+				va_opt_ws = 0;
+			}
 			*list = added;
 			list = tail;
 		}
@@ -747,6 +775,8 @@ static int expand(struct token **list, struct symbol *sym)
 	int nargs = sym->arglist ? sym->arglist->count.normal : 0;
 	struct arg args[nargs];
 
+	memset(args, 0, sizeof(args));
+
 	if (expanding->tainted) {
 		token->pos.noexpand = 1;
 		return 1;
@@ -1019,6 +1049,7 @@ static int token_different(struct token *t1, struct token *t2)
 	case TOKEN_UNTAINT:
 	case TOKEN_CONCAT:
 	case TOKEN_GNU_KLUDGE:
+	case TOKEN_VA_OPT_END:
 		different = 0;
 		break;
 	case TOKEN_NUMBER:
@@ -1030,6 +1061,7 @@ static int token_different(struct token *t1, struct token *t2)
 	case TOKEN_MACRO_ARGUMENT:
 	case TOKEN_QUOTED_ARGUMENT:
 	case TOKEN_STR_ARGUMENT:
+	case TOKEN_VA_OPT_START:
 		different = t1->argnum != t2->argnum;
 		break;
 	case TOKEN_CHAR_EMBEDDED_0 ... TOKEN_CHAR_EMBEDDED_3:
@@ -1291,21 +1323,94 @@ Econcat:
 	return NULL;
 }
 
+static int find_vararg_index(struct token *arglist)
+{
+	struct token *p;
+	int nr = 0;
+
+	if (!arglist)
+		return -1;
+	for (p = arglist->next; !eof_token(p); p = p->next->next, nr++) {
+		if (p->next->count.vararg)
+			return nr;
+	}
+	return -1;
+}
+
 static struct token *parse_expansion(struct token *expansion, struct token *arglist, struct ident *name)
 {
 	struct token *token = expansion;
 	struct token **p;
+	struct token *va_opt_start = NULL;
+	int in_va_opt = 0;
+	int va_opt_paren_depth = 0;
+	int vararg_index = find_vararg_index(arglist);
 
 	if (match_op(token, SPECIAL_HASHHASH))
 		goto Econcat;
 
 	for (p = &expansion; !eof_token(token); p = &token->next, token = *p) {
+		/* Handle __VA_OPT__(...) */
+		if (token_type(token) == TOKEN_IDENT && token->ident == &__VA_OPT___ident) {
+			struct token *next = token->next;
+
+			if (vararg_index < 0)
+				goto Eva_opt_nonva;
+			if (in_va_opt)
+				goto Eva_opt_nested;
+			if (!match_op(next, '('))
+				goto Eva_opt_paren;
+
+			/* Convert __VA_OPT__ token to TOKEN_VA_OPT_START */
+			token_type(token) = TOKEN_VA_OPT_START;
+			token->argnum = vararg_index;
+
+			/* Remove the '(' token from the list */
+			token->next = next->next;
+			__free_token(next);
+
+			/* C23: ## cannot be first token inside __VA_OPT__ */
+			if (match_op(token->next, SPECIAL_HASHHASH))
+				goto Eva_opt_hashhash;
+
+			va_opt_start = token;
+			in_va_opt = 1;
+			va_opt_paren_depth = 0;
+			continue;
+		}
+
+		/* Track parentheses inside __VA_OPT__(...) */
+		if (in_va_opt) {
+			if (match_op(token, '(')) {
+				va_opt_paren_depth++;
+			} else if (match_op(token, ')')) {
+				if (va_opt_paren_depth == 0) {
+					/* C23: ## cannot be last inside __VA_OPT__ */
+					if (token_type(va_opt_start) == TOKEN_CONCAT)
+						goto Eva_opt_hashhash;
+					/* This is the closing ) of __VA_OPT__ */
+					token_type(token) = TOKEN_VA_OPT_END;
+					in_va_opt = 0;
+					continue;
+				}
+				va_opt_paren_depth--;
+			}
+		}
+
 		if (match_op(token, '#')) {
 			token = handle_hash(p, arglist);
 			if (!token)
 				return NULL;
 		}
 		if (match_op(token->next, SPECIAL_HASHHASH)) {
+			/* C23: ## cannot be last inside __VA_OPT__ */
+			if (in_va_opt && va_opt_paren_depth == 0) {
+				struct token *t = token->next;
+				while (match_op(t, SPECIAL_HASHHASH))
+					t = t->next;
+				if (match_op(t, ')'))
+					goto Eva_opt_hashhash;
+			}
 			token = handle_hashhash(token, arglist);
 			if (!token)
 				return NULL;
@@ -1314,7 +1419,15 @@ static struct token *parse_expansion(struct token *expansion, struct token *argl
 		}
 		if (token_type(token) == TOKEN_ERROR)
 			goto Earg;
+		if (in_va_opt)
+			va_opt_start = token;
 	}
+
+	if (in_va_opt) {
+		sparse_error(expansion->pos, "unterminated __VA_OPT__");
+		return NULL;
+	}
+
 	token = alloc_token(&expansion->pos);
 	token_type(token) = TOKEN_UNTAINT;
 	token->ident = name;
@@ -1328,8 +1441,21 @@ Econcat:
 Earg:
 	sparse_error(token->pos, "too many instances of argument in body");
 	return NULL;
+Eva_opt_nonva:
+	sparse_error(token->pos, "__VA_OPT__ can only appear in the expansion of a variadic macro");
+	return NULL;
+Eva_opt_nested:
+	sparse_error(token->pos, "__VA_OPT__ may not be nested");
+	return NULL;
+Eva_opt_paren:
+	sparse_error(token->pos, "__VA_OPT__ must be followed by '('");
+	return NULL;
+Eva_opt_hashhash:
+	sparse_error(token->pos, "'##' cannot appear at either end of __VA_OPT__");
+	return NULL;
 }
 
+
 static int do_define(struct position pos, struct token *token, struct ident *name,
 		     struct token *arglist, struct token *expansion, int attr)
 {
@@ -2316,6 +2442,12 @@ static void dump_macro(struct symbol *sym)
 		case TOKEN_CONCAT:
 			printf("##");
 			break;
+		case TOKEN_VA_OPT_START:
+			printf("__VA_OPT__(");
+			break;
+		case TOKEN_VA_OPT_END:
+			printf(")");
+			break;
 		case TOKEN_STR_ARGUMENT:
 			printf("#");
 			/* fall-through */
diff --git a/token.h b/token.h
index 9000e0cb..8e05672b 100644
--- a/token.h
+++ b/token.h
@@ -104,6 +104,8 @@ enum token_type {
 	TOKEN_QUOTED_ARGUMENT,
 	TOKEN_CONCAT,
 	TOKEN_GNU_KLUDGE,
+	TOKEN_VA_OPT_START,
+	TOKEN_VA_OPT_END,
 	TOKEN_UNTAINT,
 	TOKEN_ARG_COUNT,
 	TOKEN_IF,
diff --git a/tokenize.c b/tokenize.c
index 54ea348c..44b128b7 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -237,6 +237,12 @@ const char *show_token(const struct token *token)
 		sprintf(buffer, "<end of '%s'>", stream_name(token->pos.stream));
 		return buffer;
 
+	case TOKEN_VA_OPT_START:
+		return "__VA_OPT__(";
+
+	case TOKEN_VA_OPT_END:
+		return ")";
+
 	case TOKEN_UNTAINT:
 		sprintf(buffer, "<untaint>");
 		return buffer;
diff --git a/validation/preprocessor/va-opt-errors.c b/validation/preprocessor/va-opt-errors.c
new file mode 100644
index 00000000..392b272b
--- /dev/null
+++ b/validation/preprocessor/va-opt-errors.c
@@ -0,0 +1,38 @@
+/*
+ * __VA_OPT__ error cases (C23 6.10.5)
+ *
+ * Constraints from C23 (N3220 6.10.5):
+ *   - __VA_OPT__ shall only occur in the replacement-list of a
+ *     function-like macro that uses the ellipsis notation.
+ *   - __VA_OPT__ shall not appear within its own replacement tokens.
+ *   - ## shall not appear at either end of __VA_OPT__().
+ */
+
+/* non-variadic macro */
+#define NONVAR(x) __VA_OPT__(,)
+
+/* nested __VA_OPT__ */
+#define NESTED(...) __VA_OPT__(__VA_OPT__(x))
+
+/* not followed by ( */
+#define NOPAREN(...) __VA_OPT__ x
+
+/* ## at start */
+#define HASH_START(...) __VA_OPT__(## x)
+
+/* ## at end */
+#define HASH_END(...) __VA_OPT__(x ##)
+
+/*
+ * check-name: __VA_OPT__ errors (C23)
+ * check-command: sparse -E $file
+ * check-output-ignore
+ *
+ * check-error-start
+preprocessor/va-opt-errors.c:12:19: error: __VA_OPT__ can only appear in the expansion of a variadic macro
+preprocessor/va-opt-errors.c:15:32: error: __VA_OPT__ may not be nested
+preprocessor/va-opt-errors.c:18:22: error: __VA_OPT__ must be followed by '('
+preprocessor/va-opt-errors.c:21:25: error: '##' cannot appear at either end of __VA_OPT__
+preprocessor/va-opt-errors.c:24:34: error: '##' cannot appear at either end of __VA_OPT__
+ * check-error-end
+ */
diff --git a/validation/preprocessor/va-opt.c b/validation/preprocessor/va-opt.c
new file mode 100644
index 00000000..52814fc2
--- /dev/null
+++ b/validation/preprocessor/va-opt.c
@@ -0,0 +1,66 @@
+/*
+ * __VA_OPT__ support (C23 6.10.5)
+ */
+
+/* Basic: comma insertion */
+#define A(x, ...) x __VA_OPT__(,) __VA_ARGS__
+A(1)
+A(1, 2)
+A(1, 2, 3)
+
+/* Multiple tokens inside __VA_OPT__ */
+#define B(x, ...) x __VA_OPT__(+ __VA_ARGS__ + 0)
+B(1)
+B(1, 2)
+
+/* Empty __VA_OPT__ content (just controls comma) */
+#define C(...) start __VA_OPT__(, __VA_ARGS__) end
+C()
+C(a)
+C(a, b)
+
+/* __VA_OPT__ with stringify */
+#define D(x, ...) x __VA_OPT__(, #__VA_ARGS__)
+D(1)
+D(1, hello world)
+
+/* Named varargs with __VA_OPT__ */
+#define E(x, args...) x __VA_OPT__(,) args
+E(1)
+E(1, 2)
+
+/* Empty __VA_OPT__() */
+#define F(...) prefix __VA_OPT__() suffix
+F()
+F(1)
+
+/* default_gfp() pattern from the kernel */
+#define __default_gfp(a,...) a
+#define default_gfp(...) __default_gfp(__VA_ARGS__ __VA_OPT__(,) 999)
+default_gfp()
+default_gfp(42)
+
+/*
+ * check-name: __VA_OPT__ support (C23)
+ * check-command: sparse -E $file
+ *
+ * check-output-start
+
+1
+1 , 2
+1 , 2, 3
+1
+1 + 2 + 0
+start end
+start , a end
+start , a, b end
+1
+1 , "hello world"
+1
+1 , 2
+prefix suffix
+prefix suffix
+999
+42
+ * check-output-end
+ */
-- 
2.43.0


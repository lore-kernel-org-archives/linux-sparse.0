Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A2534D4DF
	for <linux-sparse@vger.kernel.org>; Mon, 16 Mar 2026 07:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644476; cv=none; b=Km/TfzxOT2Fp+Uazuf3XApPcfa4ItiaJbninlLU3Tnk+IKB9bYnaHAM1n4i3g9r/N1hIWvb1y/POiSJIYiOnq7YKWA3uLOh+tb+9H8mmDmotf5GHNFapy0+evO/oxZt/xI+4aZqc4OIP9IRTJtxqnMglm5w5EeoNIv0NzhAwbGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644476; c=relaxed/simple;
	bh=j128si3BsX/hhoRNCXNF5aEaT1f4MBXFTlpDgWR2HlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=It+i6aSKVvSrASirpjOksyZ0TutpbUFZdGyQ6/swxiY7aTnbUFNxpmgy0igomDEhhsRdGZNJXMNGd+P85/fWbRRRnnuOiMfSQiDhFDI1L8U6FNdmA3y8tTwaPYwEeH6YlKzawXu0SRm9TNqKPKQZGiMvzsKthTXWjzx1uPzNJ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=eBXPN2OC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="eBXPN2OC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=P6SXxn5aKEK8sJVSPc9LT+aM47ByolFRCW95IcU2VEM=; b=eBXPN2OC3RU5qtyMe3uyulJxso
	slYKnXnJEeMkEL6LAXaUyQ2/x7T2DJvyKfcqbWHVICCQljC2/MeROP85SbSO5aTNDzyqs2TA7mJQg
	o4MLqq0FZN2mJ7yAarpTbIAu5Dc+21zNlrVwo1FecYphMIWvvJcekFpro7+sOfwKUNqYUBSREXF5C
	JHpn/2O+vepNyGSQco2nT8I6qUMc94zm6qV0lfFZiZsINVI4drp73NgH7orraic5opKP/mAfePkAY
	XN81qDDrkupc3kT/66hXlZBhk8jvWW+mdEw+hlze0IJiX9yzWP5KJ3RkSAqxe54OGFnIWVuw5oPV0
	Cr6sdZ5A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w21zu-00000003E3U-3dde;
	Mon, 16 Mar 2026 07:04:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-sparse@vger.kernel.org
Cc: chriscli@google.com,
	torvalds@linux-foundation.org,
	zxh@xh-zhang.com,
	ben.dooks@codethink.co.uk,
	dan.carpenter@linaro.org,
	rf@opensource.cirrus.com
Subject: [PATCH 17/21] expansion-time va_opt handling
Date: Mon, 16 Mar 2026 07:04:11 +0000
Message-ID: <20260316070415.768839-17-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316070415.768839-1-viro@zeniv.linux.org.uk>
References: <20260316065622.GA607739@ZenIV>
 <20260316070415.768839-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Teach the interpreter (== substitute()) to handle TOKEN_VA_OPT and
TOKEN_VA_OPT_STR.

Two tricky parts, both related to calculating when an argument can be
consumed.  One is that in situation like
	#define A(x,...) __VA_OPT__(x) foo_##x x
we might end up doing expansion of x either at the 1st occurrence (inside
__VA_OPT__) or at the 1st one _not_ inside __VA_OPT__ (the 3rd one in
in this example).  So at parsing time we need to keep track of whether
we'd already seen an unconditional use of expanded form and similarly
for stringified one.
	Another is that getting to the first __VA_OPT__ means that
we need to find out whether the expanded form of __VA_ARGS__ is empty.
If there'd been a prior expanding occurrence of __VA_ARGS__, we are
fine; if there hadn't, we need to make sure that unexpanded form
survives at least until that point.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 pre-process.c                               | 106 +++++++++++++++++++-
 validation/preprocessor/va_opt.c            |  54 ++++++++++
 validation/preprocessor/va_opt2.c           |  34 +++++++
 validation/preprocessor/va_opt_whitespace.c |  14 +++
 4 files changed, 204 insertions(+), 4 deletions(-)
 create mode 100644 validation/preprocessor/va_opt.c
 create mode 100644 validation/preprocessor/va_opt2.c
 create mode 100644 validation/preprocessor/va_opt_whitespace.c

diff --git a/pre-process.c b/pre-process.c
index 0f0dbc56..eec0569c 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -419,6 +419,18 @@ static struct token *stringify(struct token *arg)
 	return token;
 }
 
+static struct token *empty_string(const struct position *pos)
+{
+	struct token *token = __alloc_token(0);
+	static struct string empty = {.immutable = 1, .length = 1, .data = ""};
+
+	token->pos = *pos;
+	token_type(token) = TOKEN_STRING;
+	token->string = &empty;
+	token->next = &eof_token_entry;
+	return token;
+}
+
 /*
  * Possibly valid combinations:
  *  - ident + ident -> ident
@@ -645,11 +657,28 @@ static bool is_end_va_opt(const struct token *token)
 	return eof_token(token->next);
 }
 
+static bool skip_va_opt(struct arg *args, struct ident *expanding)
+{
+	struct token *arg = args[0].arg[ARG_NORMAL];
+	if (arg)
+		return eof_token(arg);
+	arg = args[0].arg[ARG_QUOTED];
+	if (!arg || eof_token(arg))
+		return true;
+	arg = dup_list(arg);
+	expanding->tainted = 0;
+	expand_list(&arg);
+	expanding->tainted = 1;
+	args[0].arg[ARG_NORMAL] = arg;
+	return eof_token(arg);
+}
+
 static struct token **substitute(struct token **list, const struct token *body, struct arg *args)
 {
 	struct position *base_pos = &(*list)->pos;
-	enum {Normal, Placeholder, Concat} state = Normal;
+	enum {Normal, Placeholder, Concat} state = Normal, saved_state = Normal;
 	struct ident *expanding = (*list)->ident;
+	struct token **saved_list = NULL, *va_opt_list;
 
 	expanding->tainted = 1;
 
@@ -720,6 +749,47 @@ static struct token **substitute(struct token **list, const struct token *body,
 				state = Concat;
 			continue;
 
+		case TOKEN_VA_OPT:
+			// entering va_opt?
+			if (!is_end_va_opt(body)) {
+				if (skip_va_opt(args, expanding)) {
+					if (state == Concat)
+						state = Normal;
+					else
+						state = Placeholder;
+					continue;
+				}
+				body = body->va_opt_linkage;
+				continue;
+			}
+			body = body->va_opt_linkage;
+			// leaving va_opt?
+			if (token_type(body) == TOKEN_VA_OPT)
+				continue;
+			// leaving #va_opt
+			if (list == &va_opt_list) {
+				added = empty_string(base_pos);
+			} else {
+				*list = &eof_token_entry;
+				added = stringify(va_opt_list);
+			}
+			list = saved_list;
+			state = saved_state;
+			break;
+
+		case TOKEN_VA_OPT_STR:
+			// entering #va_opt
+			if (!skip_va_opt(args, expanding)) {
+				saved_state = state;
+				state = Normal;
+				saved_list = list;
+				list = &va_opt_list;
+				body = body->va_opt_linkage;
+				continue;
+			}
+			added = empty_string(base_pos);
+			break;
+
 		default:
 			added = dup_token(body, base_pos);
 			break;
@@ -1202,9 +1272,11 @@ struct arg_state {
 	struct token *needs_raw;
 	struct token *needs_expanded;
 	struct token *needs_str;
+	bool seen_uncond_expand;
+	bool seen_uncond_str;
 };
 
-static bool in_va_opt;
+static bool in_va_opt, seen_va_opt;
 
 static struct token **parse_body(struct token **list, struct arg_state args[]);
 
@@ -1221,6 +1293,23 @@ static int parse_va_opt(struct token *token, struct arg_state args[])
 
 	if (!match_op(next, '('))
 		goto Eunterminated;
+	if (!seen_va_opt) {
+		/*
+		 * The first __VA_OPT__() will need an expanded __VA_ARGS__.
+		 * if we had no prior expanded occurrences of __VA_ARGS__,
+		 * we'll need its unexpanded form to survive until that point.
+		 * Only the cannibalization of unexpended form needs to be
+		 * prevented; cannibalization of expanded form doesn't matter.
+		 * We only want to know if it's an empty list, i.e. equal to
+		 * &eof_token_entry, and the pointer stored in struct args
+		 * ->arg[ARG_NORMAL] doesn't change when we get to the last
+		 * expanded occurrence of __VA_ARGS__ and consume the list
+		 * it's pointing to.
+		 */
+		if (!args[0].needs_expanded)
+			args[0].needs_raw = token;
+		seen_va_opt = true;
+	}
 	token_type(token) = TOKEN_VA_OPT;
 	token->va_opt_linkage = next;
 	next->next->pos.whitespace = token->pos.whitespace;
@@ -1292,13 +1381,19 @@ static void seen_arg(struct token *token, enum arg_kind kind, struct arg_state a
 		args[nr].needs_raw = token;
 		break;
 	case ARG_NORMAL:
-		if (!args[nr].needs_expanded)
+		if (!args[nr].seen_uncond_expand &&
+		    (!in_va_opt || !args[nr].needs_expanded)) {
+			args[nr].seen_uncond_expand = !in_va_opt;
 			args[nr].needs_raw = token;
+		}
 		args[nr].needs_expanded = token;
 		break;
 	default: // ARG_STR
-		if (!args[nr].needs_str)
+		if (!args[nr].seen_uncond_str &&
+		    (!in_va_opt || !args[nr].needs_str)) {
+			args[nr].seen_uncond_str = !in_va_opt;
 			args[nr].needs_raw = token;
+		}
 		args[nr].needs_str = token;
 	}
 }
@@ -1436,6 +1531,7 @@ static struct token *parse_expansion(struct token *expansion, struct ident *name
 	struct token *token;
 
 	tail = parse_body(&expansion, args);
+	seen_va_opt = false;
 	if (!tail)
 		return NULL;
 	for (int i = 0; i < slots; i++) {
@@ -1445,6 +1541,8 @@ static struct token *parse_expansion(struct token *expansion, struct ident *name
 			args[i].needs_expanded->argnum |= 1 << ARGNUM_CONSUME;
 		if (args[i].needs_raw) {
 			struct token *p = args[i].needs_raw;
+			if (token_type(p) != TOKEN_MACRO_ARGUMENT)
+				continue;
 			if (argkind(p) == ARG_QUOTED)
 				p->argnum |= 1 << ARGNUM_CONSUME;
 			else if (argkind(p) == ARG_NORMAL)
diff --git a/validation/preprocessor/va_opt.c b/validation/preprocessor/va_opt.c
new file mode 100644
index 00000000..4fa38794
--- /dev/null
+++ b/validation/preprocessor/va_opt.c
@@ -0,0 +1,54 @@
+#define LPAREN() (
+#define G(Q) 42
+#define F(R, X, ...) __VA_OPT__(G R X) )
+int x = F(LPAREN(), 0, <:-); // replaced by int x = 42;
+#undef F
+#undef G
+#define F(...) f(0 __VA_OPT__(,) __VA_ARGS__)
+#define G(X, ...) f(0, X __VA_OPT__(,) __VA_ARGS__)
+#define SDEF(sname, ...) S sname __VA_OPT__(= { __VA_ARGS__ })
+#define EMP
+F(a, b, c) // replaced by f(0, a, b, c)
+F() // replaced by f(0)
+F(EMP) // replaced by f(0)
+G(a, b, c) // replaced by f(0, a, b, c)
+G(a, ) // replaced by f(0, a)
+G(a) // replaced by f(0, a)
+SDEF(foo); // replaced by S foo;
+SDEF(bar, 1, 2); // replaced by S bar = { 1, 2 };
+// may not appear at the beginning of a replacement
+// list (6.10.5.3)
+#define H2(X, Y, ...) __VA_OPT__(X ## Y,) __VA_ARGS__
+H2(a, b, c, d) // replaced by ab, c, d
+#define H3(X, ...) #__VA_OPT__(X##X X##X)
+H3(, 0) // replaced by ""
+#define H4(X, ...) __VA_OPT__(a X ## X) ## b
+H4(, 1) // replaced by a b
+#define H5A(...) __VA_OPT__()/**/__VA_OPT__()
+#define H5B(X) a ## X ## b
+#define H5C(X) H5B(X)
+H5C(H5A()) // replaced by ab
+/*
+ * check-name: __VA_OPT__ expansion (examples from C23)
+ * check-command: sparse -E $file
+ *
+ * check-output-start
+
+int x = 42;
+f(0 , a, b, c)
+f(0)
+f(0)
+f(0, a , b, c)
+f(0, a)
+f(0, a)
+S foo;
+S bar = { 1, 2 };
+ab, c, d
+""
+a b
+ab
+ * check-output-end
+ *
+ * check-error-start
+ * check-error-end
+ */
diff --git a/validation/preprocessor/va_opt2.c b/validation/preprocessor/va_opt2.c
new file mode 100644
index 00000000..5523301e
--- /dev/null
+++ b/validation/preprocessor/va_opt2.c
@@ -0,0 +1,34 @@
+#define B(X) 1
+// don't screw unexpanded __VA_ARGS__ on prior __VA_OPT__
+#define A(...) __VA_OPT__(1) A##__VA_ARGS__
+A(B(_))
+// tests for skipping __VA_OPT__ don't care if expanded __VA_ARGS__
+// has been already consumed
+#define C(...) [__VA_ARGS__ __VA_OPT__(1)]
+C(_)
+C()
+// don't cannibalize unexpanded __VA_ARGS__ too early
+#define E(X)
+#define D(...) A##__VA_ARGS__ R __VA_OPT__(1)
+D(E(_))
+// check that parser clears seen_va_opt on failure exit
+#define BAD(...) __VA_OPT__(,) #1
+#define F(...) A##__VA_ARGS__ R __VA_OPT__(1)
+F(E(_))
+/*
+ * check-name: __VA_ARGS__ cannibalization with __VA_OPT__
+ * check-command: sparse -E $file
+ *
+ * check-output-start
+
+1 AB(_)
+[_ 1]
+[]
+AE(_) R
+AE(_) R
+ * check-output-end
+ *
+ * check-error-start
+preprocessor/va_opt2.c:15:32: error: '#' is not followed by a macro parameter
+ * check-error-end
+ */
diff --git a/validation/preprocessor/va_opt_whitespace.c b/validation/preprocessor/va_opt_whitespace.c
new file mode 100644
index 00000000..727327f0
--- /dev/null
+++ b/validation/preprocessor/va_opt_whitespace.c
@@ -0,0 +1,14 @@
+#define A(X,...) [__VA_OPT__( X)][ __VA_OPT__(X)]
+A(1,_)
+/*
+ * check-name: __VA_OPT__ whitespace
+ * check-command: sparse -E $file
+ *
+ * check-output-start
+
+[1][ 1]
+ * check-output-end
+ *
+ * check-error-start
+ * check-error-end
+ */
-- 
2.47.3


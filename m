Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256427;
	b=ScoSN69bpocKQ0ZzPfgbgsso6w9bGWoaYnZ1TLAsaGE2nIz59MTbGa8eWNgQFXlYDW6+
	 VS3GdAyeUteUsYWCSCfbmJ4L18oAN0jA0ib+ibUXWipERrSAvy+AKEMKQoR/7ZLmnmAh6
	 XxwsnzrCkU+8OruY8mMEuJSilSQKqPSuag6wVL7fjdO+dqPtNQZo0Au6SYvd6Ynasrb42
	 1R1ED9hFm52XthBvXg924j2qKooaZ/M4SHyf2YRZYAagxETUzKhF5AikbKTiF9hJLL6iG
	 U3k4j7EFAmQb6gJkBdKXA6VGdbwxJ4Dl0TBv3WMlo8/MHvPHzSfhxG9rzu0IQnxWBPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256427;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=lyVetQ86lWr7Bni1KNWQPcDofg3G1TPsbbdksWd5su0=;
	b=Qv+KmC+GyRGk6ZtuXPxW2TdGzmgzc3Bd6VfiI9rmANniEuGTEFQFTPvrjvhly01Wkfwy
	 0e8NWMaBjIf0okt3iuN/yb/qQaB09t56hR9wpiVwFOUnHyLeO6JAxlfb6ZnlwNVeuE99k
	 utcMghrg6XpUKbFrrZBNvLPR7KNOC9A3unNiup1UkE+G8JILJ/B7SrbV1js7/5Kidk6Jt
	 vt8di3MvxzotWNgEnWsPt17JygraZEzA9WtOdSY89JwBONcIrqzZIMKedp7rDUzmTmhjb
	 7KP2c1un1PWQE7XeAahHlRw9P4OvFpk6lD2zcFfyI2wwrM6eLmesYIf76PYNqZZnvIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=iKm8oV+f;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C63606A31C
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68C63606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=iKm8oV+f
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhMB4RX3z1XMYJR;
	Mon,  9 Nov 2026 20:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256416; x=1796848417; bh=lyVet
	Q86lWr7Bni1KNWQPcDofg3G1TPsbbdksWd5su0=; b=iKm8oV+fm9xZ0PV1vPHqi
	KAG0pRAbZUBBQWK0CH4j1V82g883zfc5RZALpbo33OVEHyoJZkPTQ7Ta2XzwgInk
	Tdfnw51Z2tbtxSHqD0xgpMvyv6f3HIozqdsddm9qeJx4BamIu9qXdnkCPqhw9phm
	Osu2ZkiiSnaDwcUHRwezf9/5oQOSYn1cicBhqYLr7tWSYqkxrv8vldnH2Mbanawr
	pNI/8HldUr/8WjTCc9vn8QEox8jWHc/+NVIC2XngaYyZClMTELDCV5plCqvP979X
	ssCTgp+9XRtbU3hKKuBOQ97/VmwPmdPZBnfb82lqcAo7IwUoSsyVk74FRCrpqYu/
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id waHHJEFrcEQA; Mon,  9 Nov 2026 20:33:36 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM23sFqz1XMYJj;
	Mon,  9 Nov 2026 20:33:34 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 46/73] c23: Support unnamed parameters in function definitions
Date: Mon,  9 Nov 2026 12:32:32 -0800
Message-ID: <20261109203259.362845-47-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109203259.362845-1-bvanassche@acm.org>
References: <20261109203259.362845-1-bvanassche@acm.org>
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Post: <mailto:linux-sparse@vger.kernel.org>
List-Help: <mailto:linux-sparse+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sparse+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Allow function definitions to omit parameter names in C23 mode per ISO
C23 6.9.1 while rejecting unnamed parameters as an error in pre-C23
standards:
- Check for missing type specifiers before skipping local scope binding
  for unnamed parameters.
- Preserve argument side effects when inlining calls to functions with
  unnamed parameters without triggering unreplaced-symbol warnings.
- Advance parameter slot indices across unnamed parameters during
  linearization so subsequent named parameters keep their ABI slot index.
- Reject qualified, named, or multi-parameter uses of 'void'.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 inline.c                                 |  6 ++-
 linearize.c                              |  8 ++--
 parse.c                                  | 27 +++++++++-----
 validation/c23-unnamed-params-error.c    | 27 ++++++++++++++
 validation/c23-unnamed-params-pedantic.c | 12 ++++++
 validation/c23-unnamed-params.c          | 47 ++++++++++++++++++++++++
 validation/linear/c23-unnamed-params.c   | 27 ++++++++++++++
 7 files changed, 141 insertions(+), 13 deletions(-)
 create mode 100644 validation/c23-unnamed-params-error.c
 create mode 100644 validation/c23-unnamed-params-pedantic.c
 create mode 100644 validation/c23-unnamed-params.c
 create mode 100644 validation/linear/c23-unnamed-params.c

diff --git a/inline.c b/inline.c
index d94fba807d19..d3f27952138b 100644
--- a/inline.c
+++ b/inline.c
@@ -631,7 +631,7 @@ int inline_function(struct expression *expr, struct s=
ymbol *sym)
 	FOR_EACH_PTR(expr->args, arg) {
 		struct symbol *a =3D alloc_symbol(arg->pos, SYM_NODE);
=20
-		if (name) {
+		if (name && name->ident) {
 			*a =3D *name;
 			a->bb_target =3D NULL;
 			a->pseudo =3D NULL;
@@ -639,6 +639,10 @@ int inline_function(struct expression *expr, struct =
symbol *sym)
 			add_symbol(&fn_symbol_list, a);
 			a->initializer =3D arg;
 			add_symbol(&arg_decl, a);
+		} else if (name) {
+			*a =3D *name;
+			a->initializer =3D arg;
+			add_symbol(&arg_decl, a);
 		} else {
 			// This may create a node of a node but it will
 			// be resolved later when the corresponding
diff --git a/linearize.c b/linearize.c
index 422cee820ddb..4179aea03af1 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2607,12 +2607,14 @@ static struct entrypoint *linearize_fn(struct sym=
bol *sym, struct symbol *base_t
 	add_one_insn(ep, entry);
 	ep->entry =3D entry;
=20
-	concat_symbol_list(base_type->arguments, &ep->syms);
-
 	/* FIXME!! We should do something else about varargs.. */
 	i =3D 0;
 	FOR_EACH_PTR(base_type->arguments, arg) {
-		linearize_argument(ep, arg, ++i);
+		++i;
+		if (!arg->ident)
+			continue;
+		add_symbol(&ep->syms, arg);
+		linearize_argument(ep, arg, i);
 	} END_FOR_EACH_PTR(arg);
=20
 	result =3D linearize_fn_statement(ep, stmt);
diff --git a/parse.c b/parse.c
index 5e526b0cc840..6af5bfba2392 100644
--- a/parse.c
+++ b/parse.c
@@ -1702,6 +1702,8 @@ static struct token *declaration_specifiers(struct =
token *token, struct decl_sta
 				specifier_conflict(token->pos,
 						   seen & s->op->test,
 						   token->ident);
+				ctx->ctype.base_type =3D &bad_ctype;
+				seen |=3D Set_S;
 				break;
 			}
 			seen |=3D s->op->set;
@@ -2772,10 +2774,12 @@ static struct token *parameter_type_list(struct t=
oken *token, struct symbol *fn)
 		sym =3D alloc_symbol(token->pos, SYM_NODE);
 		token =3D parameter_declaration(token, sym);
 		if (sym->ctype.base_type =3D=3D &void_ctype) {
-			/* Special case: (void) */
-			if (!*list && !sym->ident)
+			/* Special case: sole unnamed unqualified (void) */
+			if (!*list && !sym->ident && match_op(token, ')') &&
+			    !(sym->ctype.modifiers & (MOD_QUALIFIER | MOD_STORAGE | MOD_ATOMI=
C)))
 				break;
-			warning(token->pos, "void parameter");
+			sparse_error(sym->pos, "'void' must be the only parameter");
+			sym->ctype.base_type =3D &bad_ctype;
 		}
 		add_symbol(list, sym);
 		if (!match_op(token, ','))
@@ -2917,18 +2921,23 @@ struct token *initializer(struct expression **tre=
e, struct token *token)
=20
 static void declare_argument(struct symbol *sym, struct symbol *fn)
 {
-	if (!sym->ident) {
-		sparse_error(sym->pos, "no identifier for function argument");
-		return;
-	}
 	if (sym->ctype.base_type =3D=3D &incomplete_ctype) {
 		sym->ctype.base_type =3D &int_ctype;
=20
 		if (Wimplicit_int) {
-			sparse_error(sym->pos, "missing type declaration for parameter '%s'",
-				show_ident(sym->ident));
+			if (sym->ident)
+				sparse_error(sym->pos, "missing type declaration for parameter '%s'"=
,
+					show_ident(sym->ident));
+			else
+				sparse_error(sym->pos, "missing type declaration for parameter");
 		}
 	}
+	if (!sym->ident) {
+		if (standard < STANDARD_C23 && sym->ctype.base_type !=3D &bad_ctype)
+			sparse_error(sym->pos,
+				     "omitting parameter name in function definition is a C23 featur=
e");
+		return;
+	}
 	bind_symbol(sym, sym->ident, NS_SYMBOL);
 }
=20
diff --git a/validation/c23-unnamed-params-error.c b/validation/c23-unnam=
ed-params-error.c
new file mode 100644
index 000000000000..6630f96b53b5
--- /dev/null
+++ b/validation/c23-unnamed-params-error.c
@@ -0,0 +1,27 @@
+static void f_implicit(const)
+{
+}
+
+static void f_void1(void, int)
+{
+}
+
+static void f_void2(int, void)
+{
+}
+
+static void f_cvoid(const void)
+{
+}
+
+/*
+ * check-name: c23-unnamed-params-error
+ * check-command: sparse -std=3Dc23 $file
+ *
+ * check-error-start
+c23-unnamed-params-error.c:1:24: error: missing type declaration for par=
ameter
+c23-unnamed-params-error.c:5:21: error: 'void' must be the only paramete=
r
+c23-unnamed-params-error.c:9:26: error: 'void' must be the only paramete=
r
+c23-unnamed-params-error.c:13:21: error: 'void' must be the only paramet=
er
+ * check-error-end
+ */
diff --git a/validation/c23-unnamed-params-pedantic.c b/validation/c23-un=
named-params-pedantic.c
new file mode 100644
index 000000000000..aa2a204628fe
--- /dev/null
+++ b/validation/c23-unnamed-params-pedantic.c
@@ -0,0 +1,12 @@
+static void f1(int)
+{
+}
+
+/*
+ * check-name: c23-unnamed-params-pedantic
+ * check-command: sparse -std=3Dc11 $file
+ *
+ * check-error-start
+c23-unnamed-params-pedantic.c:1:16: error: omitting parameter name in fu=
nction definition is a C23 feature
+ * check-error-end
+ */
diff --git a/validation/c23-unnamed-params.c b/validation/c23-unnamed-par=
ams.c
new file mode 100644
index 000000000000..ddecb8e9e0b9
--- /dev/null
+++ b/validation/c23-unnamed-params.c
@@ -0,0 +1,47 @@
+static void f1(int)
+{
+}
+
+static void f2(int, double)
+{
+}
+
+static int f3(int a, double, int b)
+{
+	return a + b;
+}
+
+static void f4(void (*)(int))
+{
+}
+
+static void f5(int [static 4], const int)
+{
+}
+
+static inline int inl_unnamed(int a, int, int b)
+{
+	return a + b;
+}
+
+static int bump(int *cnt)
+{
+	return (*cnt)++;
+}
+
+static int test_calls(void)
+{
+	int arr[4] =3D { 1, 2, 3, 4 };
+	int cnt =3D 0;
+
+	f1(1);
+	f2(2, 3.0);
+	f4(f1);
+	f5(arr, 7);
+	return f3(10, 0.5, 20) + inl_unnamed(1, bump(&cnt), 2) + cnt;
+}
+
+/*
+ * check-name: c23-unnamed-params
+ * check-command: sparse -std=3Dc23 -pedantic $file
+ */
diff --git a/validation/linear/c23-unnamed-params.c b/validation/linear/c=
23-unnamed-params.c
new file mode 100644
index 000000000000..add966d3ea71
--- /dev/null
+++ b/validation/linear/c23-unnamed-params.c
@@ -0,0 +1,27 @@
+int f3(int a, double, int b);
+int f3(int a, double, int b)
+{
+	return a + b;
+}
+
+static inline int inl(int a, int, int b)
+{
+	return a + b;
+}
+
+extern int side_effect(void);
+
+int caller(void);
+int caller(void)
+{
+	return inl(10, side_effect(), 20);
+}
+
+/*
+ * check-name: linear-c23-unnamed-params
+ * check-command: test-linearize -m64 -std=3Dc23 $file
+ *
+ * check-output-ignore
+ * check-output-contains: add\\.32 *%r[0-9]* <- %arg1, %arg3
+ * check-output-contains: call\\.32 *%r[0-9]* <- side_effect
+ */

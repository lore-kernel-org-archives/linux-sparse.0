Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256432;
	b=oYH2fidykKtjiWnL447irXfGeD5D+CsArEcDAvz6tBfNKrus3A593D5lTmDkLkL6W1hk
	 OTdDswupo3yuPC6OqRKV92chOtGYhAMj+YKr2BA/lZqM0IqohNRD8CGN4Upup7mFdMX9j
	 /4ZeOa7FifxqD4u1KMCIrt0vxmlfSE70NdcuiSM4zp+04+MH5Cf59Ij+uoQioE5wAgENS
	 if927FibOQuMcHPMuxgH9nEA5n8zFUOmH47HUNLBkbwPTQJdc3iiEuh3LTTN1Sl/tAGSy
	 LLiL1lpQkHrQbic6byvAujrkIHtuld8zrQXr+qv1+FqjD+Hl1hHWD1mN7XDyrdaofHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=4gj5fhcpfBSax3ZhuTMoRXv+HQ296zTx7IhsnzbkyD4=;
	b=T152cObp3qYrW0Ci/FQbRdJHow8g2zsrO+EYPKtkGKs9n5fru/qnlbwztps1JXaIw0sD
	 PV+vOv4DJ1I2PDNLrHMRR/vsqyeEtniBCNQoLWCae+c3OlnSMhV8arpXy9qcP/GlXRIjk
	 y+SOHIMsRd/LkgblI8zwLrnB29O75kpqwwCdK25uq68A4oot5JY487179erVKAYASfVcA
	 wInVt8+mMwBzpXqiV3XZ85SneXSzEwCbSvRuw6SoG/wVoMhhSud0bpxyVdPg8p6xmOzdK
	 2F9AIRDymLoVnB5FDikN6jnw2NKvy0odVgDF/WL8uSsh5SkDPTCxQBh1S0UPMS9HsiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=4+ObnAYo;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2629D606A325
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2629D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=4+ObnAYo
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhMF14sxz1XLwXF;
	Mon,  9 Nov 2026 20:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256418; x=1796848419; bh=4gj5f
	hcpfBSax3ZhuTMoRXv+HQ296zTx7IhsnzbkyD4=; b=4+ObnAYoLcgme1JOEOPGM
	iLi+4UsQcZ7Q6yGYRJ6athfv8xSAFfrVyW/CJFCxvKstOm+bLnOxK+ict9AVsbH1
	FKAmxfQwX3dzNGUd8ITLzoVXMoBZt6vQpe5qdM63i3Yh2SVDq7s9A4UZ8wh1GelA
	8zy+7Fh7klSHvxLfievVD56JG5O6mnqmEaCpqWK7IT8N+rFGJYbhfxROMm1L5EKn
	dJpdMZv0VB6BnQLik4GFp5p4ZFiTR5Ai6U54/5qpB7CufrRo41IIpuWkgCaHkR2d
	PWFAyxB4HvaaIXi4sBMRlLqtGVYngs2U5vGrr6Te8bcPh0ctBGE9fxjTWXvzSV+r
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id VX3NPrcRtD31; Mon,  9 Nov 2026 20:33:38 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM530gvz1XMYJk;
	Mon,  9 Nov 2026 20:33:37 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 59/73] c23: Treat empty parameter list () as (void) and reject K&R functions
Date: Mon,  9 Nov 2026 12:32:45 -0800
Message-ID: <20261109203259.362845-60-bvanassche@acm.org>
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

Treat an empty parameter list '()' in a function declarator as '(void)'
and reject K&R identifier-list function declarations and definitions in
C23 mode per ISO C23 6.7.6.3 and 6.9.1:
- Parse '()' as a zero-parameter prototype in C23 mode so calls with
  arguments and conflicting redeclarations are diagnosed.
- Track identifier-list declarators via kr_args on SYM_FN and report an
  error in C23 mode on K&R function definitions (with or without
  parameter declarations) and K&R function or function-pointer
  declarations.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 parse.c                             | 34 ++++++++++++++++++---
 symbol.h                            |  1 +
 validation/c23-empty-parameters.c   | 29 ++++++++++++++++++
 validation/c23-empty-params-error.c | 47 +++++++++++++++++++++++++++++
 validation/c23-knr-error.c          | 14 +++++++++
 5 files changed, 120 insertions(+), 5 deletions(-)
 create mode 100644 validation/c23-empty-parameters.c
 create mode 100644 validation/c23-empty-params-error.c
 create mode 100644 validation/c23-knr-error.c

diff --git a/parse.c b/parse.c
index f49b3f188c69..782683a84fba 100644
--- a/parse.c
+++ b/parse.c
@@ -2241,9 +2241,14 @@ static enum kind which_func(struct token *token,
 		if (lookup_type(next) || next !=3D token->next)
 			return Proto;
 		/* identifier list not in definition; complain */
-		if (prefer_abstract)
-			warning(token->pos,
-				"identifier list not in definition");
+		if (prefer_abstract || !n) {
+			if (standard >=3D STANDARD_C23)
+				sparse_error(token->pos,
+					     "identifier list not in definition");
+			else
+				warning(token->pos,
+					"identifier list not in definition");
+		}
 		return K_R;
 	}
=20
@@ -2251,6 +2256,8 @@ static enum kind which_func(struct token *token,
 		return Bad_Func;
=20
 	if (next->special =3D=3D ')') {
+		if (standard >=3D STANDARD_C23)
+			return Proto;
 		/* don't complain about those */
 		if (!n || match_op(next->next, ';') || match_op(next->next, ','))
 			return Empty;
@@ -3284,6 +3291,7 @@ static struct token * statement_list(struct token *=
token, struct statement_list
 static struct token *identifier_list(struct token *token, struct symbol =
*fn)
 {
 	struct symbol_list **list =3D &fn->arguments;
+	fn->kr_args =3D 1;
 	for (;;) {
 		struct symbol *sym =3D alloc_symbol(token->pos, SYM_NODE);
 		sym->ident =3D token->ident;
@@ -3304,6 +3312,9 @@ static struct token *parameter_type_list(struct tok=
en *token, struct symbol *fn)
 {
 	struct symbol_list **list =3D &fn->arguments;
=20
+	if (match_op(token, ')'))
+		return token;
+
 	for (;;) {
 		struct symbol *sym;
=20
@@ -3602,7 +3613,10 @@ static struct token *parse_k_r_arguments(struct to=
ken *token, struct symbol *dec
 {
 	struct symbol_list *args =3D NULL;
=20
-	if (Wold_style_definition)
+	if (standard >=3D STANDARD_C23)
+		sparse_error(token->pos,
+			     "old-style function definition is invalid in C23");
+	else if (Wold_style_definition)
 		warning(token->pos, "non-ANSI definition of function '%s'", show_ident=
(decl->ident));
=20
 	do {
@@ -3772,8 +3786,15 @@ struct token *external_declaration(struct token *t=
oken, struct symbol_list **lis
 		}
 		if (lookup_type(token))
 			return parse_k_r_arguments(token, decl, list);
-		if (match_op(token, '{'))
+		if (match_op(token, '{')) {
+			if (standard >=3D STANDARD_C23 && base_type->kr_args)
+				sparse_error(decl->pos,
+					     "old-style function definition is invalid in C23");
 			return parse_function_body(token, decl, list);
+		}
+		if (standard >=3D STANDARD_C23 && base_type->kr_args)
+			sparse_error(decl->pos,
+				     "identifier list not in function definition");
=20
 		if (!(decl->ctype.modifiers & MOD_STATIC))
 			decl->ctype.modifiers |=3D MOD_EXTERN;
@@ -3977,6 +3998,9 @@ struct token *external_declaration(struct token *to=
ken, struct symbol_list **lis
 		base_type =3D decl->ctype.base_type;
 		if (!is_typedef && base_type && base_type->type =3D=3D SYM_FN) {
 			decl->ctype.modifiers |=3D ctx.f_modifiers;
+			if (standard >=3D STANDARD_C23 && base_type->kr_args)
+				sparse_error(decl->pos,
+					     "identifier list not in function definition");
 			if (!(decl->ctype.modifiers & MOD_STATIC))
 				decl->ctype.modifiers |=3D MOD_EXTERN;
 		}
diff --git a/symbol.h b/symbol.h
index a072ac8fc739..942baad97df5 100644
--- a/symbol.h
+++ b/symbol.h
@@ -198,6 +198,7 @@ struct symbol {
 				packed : 1, transparent_union : 1,
 				fixed_type : 1;
 			unsigned int has_alignas : 1;
+			unsigned int kr_args : 1;
 			unsigned int underspecified : 1;
 			unsigned int c23_auto : 1;
 			int		rank:3;	// arithmetic's rank
diff --git a/validation/c23-empty-parameters.c b/validation/c23-empty-par=
ameters.c
new file mode 100644
index 000000000000..9c493256d54b
--- /dev/null
+++ b/validation/c23-empty-parameters.c
@@ -0,0 +1,29 @@
+int f();
+int f(void)
+{
+	return 0;
+}
+
+int g(void);
+int g()
+{
+	return 1;
+}
+
+static int h()
+{
+	return 2;
+}
+
+static int test(void)
+{
+	int (*fp)() =3D f;
+	int (*fp2)(void) =3D h;
+
+	return fp() + fp2() + g();
+}
+
+/*
+ * check-name: c23-empty-parameters
+ * check-command: sparse -std=3Dc23 -Wstrict-prototypes -pedantic $file
+ */
diff --git a/validation/c23-empty-params-error.c b/validation/c23-empty-p=
arams-error.c
new file mode 100644
index 000000000000..4c0efe972358
--- /dev/null
+++ b/validation/c23-empty-params-error.c
@@ -0,0 +1,47 @@
+int f();
+
+static int h()
+{
+	return 0;
+}
+
+int mismatch();
+int mismatch(int x)
+{
+	return x;
+}
+
+int ident_decl(a, b);
+int (*bad_fp)(a, b);
+
+int old_implicit(a, b)
+{
+	return 0;
+}
+
+static void bad_calls(int (*fp)())
+{
+	f(1);
+	h(1, 2);
+	fp(3);
+}
+
+/*
+ * check-name: c23-empty-params-error
+ * check-command: sparse -std=3Dc23 -Wno-decl $file
+ *
+ * check-error-start
+c23-empty-params-error.c:14:5: error: identifier list not in function de=
finition
+c23-empty-params-error.c:15:14: error: identifier list not in definition
+c23-empty-params-error.c:17:5: error: old-style function definition is i=
nvalid in C23
+c23-empty-params-error.c:17:18: error: missing type declaration for para=
meter 'a'
+c23-empty-params-error.c:17:21: error: missing type declaration for para=
meter 'b'
+c23-empty-params-error.c:9:5: error: symbol 'mismatch' redeclared with d=
ifferent type (different argument counts):
+c23-empty-params-error.c:9:5:    int extern [addressable] [signed] [topl=
evel] mismatch( ... )
+c23-empty-params-error.c:8:5: note: previously declared as:
+c23-empty-params-error.c:8:5:    int extern [addressable] [signed] [topl=
evel] mismatch( ... )
+c23-empty-params-error.c:24:10: error: too many arguments for function f
+c23-empty-params-error.c:25:10: error: too many arguments for function h
+c23-empty-params-error.c:26:11: error: too many arguments for function f=
p
+ * check-error-end
+ */
diff --git a/validation/c23-knr-error.c b/validation/c23-knr-error.c
new file mode 100644
index 000000000000..f7ae837815b5
--- /dev/null
+++ b/validation/c23-knr-error.c
@@ -0,0 +1,14 @@
+int old_func(a, b)
+int a, b;
+{
+	return a + b;
+}
+
+/*
+ * check-name: c23-knr-error
+ * check-command: sparse -std=3Dc23 $file
+ *
+ * check-error-start
+c23-knr-error.c:2:1: error: old-style function definition is invalid in =
C23
+ * check-error-end
+ */

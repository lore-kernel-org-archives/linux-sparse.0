Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256437;
	b=4ysme5Cn/tcLJKnwmSHV35583nkZZI7MblNo6nIuKU8Hds1vfSCU60QAds3Zjg5gafGJ
	 rKeFLtsPa/jlik3MzUHpjCsdwfGZ4A7DgJg595yf/o261Ha86kRraQziHpOaZbC4oT9hi
	 StZ9AaigIlKWhbIWnnL5tLqzhRGg7BPm0z8BnlTPX7ky4imesfTF7o7ayj20U64e7WaQ4
	 60cGKyD6Nkcgw51mtOPpYX0Ips6KrKXXZtKuan3sXrH3F6S7hX3RtkvSuLvTvgHGVz5lg
	 l/9gWBGMO/lIwEw+uZ5JX4v4tcZoH2iWe8V2JaJe45sONQEIkGvpyfK5Tt+8glFfAwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256437;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=3nIWFbb+rhSQ+EJiO5bdSjQvrFP8ALVerIXH7bE+v7o=;
	b=Ngf7g6cPNV/cU7gMq7UPTrOM3PR0pfvC5nEzLc2m02mEnnZAXhxG70inQ7iIidnoTHxi
	 ZdohwAuEJs1txQDJE9YXy9cRQ+tGhCpddvcCqSswxkw3AEKefwWN96a76cl0Ue1yeBw3D
	 auJV7K/Vey9t77qD2jN3/e6/COs8kFy4ACiEQv1IuTgypcjx1SNf8ntVcVEHdufs0ONAh
	 VvDrjOAnvHcEmPHUndu1zzCWHX/peqZs7Tk7kU1NrnXWDrz6tAcI74DTWa1S1wdog+1/Y
	 pf/fmw5F//VCNkzC0YJ6wxNyKDfBTFaH79kAkcEjI2/pE5mObBHDlVRPKpRtlecJWsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=JnrNAETF;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FDC606A325
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5FDC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=JnrNAETF
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhMJ2Mzjz1XMYJV;
	Mon,  9 Nov 2026 20:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256420; x=1796848421; bh=3nIWF
	bb+rhSQ+EJiO5bdSjQvrFP8ALVerIXH7bE+v7o=; b=JnrNAETFCbVw9C7ZoqUdZ
	f4ff05KmJCQtf7nG3jntKiDTd7Sg4i7nblZbfROnpxPF5ecthvMvtmx7W17M2nYJ
	8x82gKFWoBHqF3naRzCKQz2HY68JEks0MuGLmXdPdP3UrkUy+BXL1+t6eDFIZRt9
	nXKCZKINCpYnsQLvokr8+Gjk7hFKwyCOZlIhrqwl9O4nuHxELpG1zIvr2dC0Tyjp
	6yrY10Po+QUwZw99KIieC1RwGp7z63YFr01Fa0ClhZVfEFOr7mcPYwlEaxt9pxNC
	03pfSnGI4sVHhB7OIZCKT31HCT0UQvO+TRhwDh/XWi6MCabpjR1conGFmtlHu2yX
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 08Xhiwr35X8m; Mon,  9 Nov 2026 20:33:40 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM828jLz1XMfrl;
	Mon,  9 Nov 2026 20:33:40 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 72/73] evaluate: Accept conditional expressions with only one void side
Date: Mon,  9 Nov 2026 12:32:58 -0800
Message-ID: <20261109203259.362845-73-bvanassche@acm.org>
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

Accept conditional expressions in which exactly one of the second and
third operands has complete type void as a GNU extension matching GCC
and Clang: give the expression type void, evaluate the non-void operand
only for its side effects, warn only under -Wpedantic, and avoid
emitting zero-sized phi nodes in linearize_conditional().

Support Linux kernel macros such as STA_ASSIGN in net/mac80211/trace.h
and nfs_errorf() in fs/nfs/internal.h without false "incompatible types
in conditional expression" errors while continuing to diagnose uses of
the void result value.

Update validation/cond-err-expand.c and add validation/cond-one-void.c
and validation/cond-one-void-pedantic.c.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 evaluate.c                          | 113 ++++++++++++++++++----------
 expand.c                            |  17 ++++-
 linearize.c                         |  19 +++++
 validation/cond-err-expand.c        |   9 ---
 validation/cond-one-void-pedantic.c |  39 ++++++++++
 validation/cond-one-void.c          |  47 ++++++++++++
 validation/linear/cond-one-void.c   |  24 ++++++
 7 files changed, 217 insertions(+), 51 deletions(-)
 create mode 100644 validation/cond-one-void-pedantic.c
 create mode 100644 validation/cond-one-void.c
 create mode 100644 validation/linear/cond-one-void.c

diff --git a/evaluate.c b/evaluate.c
index 6e1be32f929f..927c4f35d831 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1421,6 +1421,37 @@ static struct symbol *evaluate_conditional_express=
ion(struct expression *expr)
=20
 	lclass =3D classify_type(ltype, &ltype);
 	rclass =3D classify_type(rtype, &rtype);
+
+	/*
+	 * GNU extension supported by gcc and clang: if exactly one of the
+	 * second and third operands has type void, the result has type void
+	 * and the other operand is only evaluated for its side effects.
+	 * ISO C forbids this [6.5.15(3)].
+	 */
+	if ((ltype =3D=3D &void_ctype) !=3D (rtype =3D=3D &void_ctype)) {
+		struct symbol *other_type =3D (ltype =3D=3D &void_ctype) ? rtype : lty=
pe;
+
+		if (!valid_type(other_type)) {
+			expr->flags =3D CEF_NONE;
+			expr->ctype =3D &bad_ctype;
+			return NULL;
+		}
+		if (other_type =3D=3D &incomplete_ctype || other_type->bit_size < 0 ||
+		    ((other_type->type =3D=3D SYM_STRUCT || other_type->type =3D=3D SY=
M_UNION) &&
+		     !other_type->defined)) {
+			expression_error(expr, "expression has incomplete type '%s'",
+					 show_typename(other_type));
+			return NULL;
+		}
+		if (Wpedantic)
+			warning(expr->pos, "ISO C forbids conditional expression with only on=
e void side");
+		if (expr->cond_true)
+			*cond =3D cast_to(*cond, &void_ctype);
+		expr->cond_false =3D cast_to(expr->cond_false, &void_ctype);
+		ctype =3D &void_ctype;
+		goto out;
+	}
+
 	if (lclass & rclass & TYPE_NUM) {
 		ctype =3D usual_conversions('?', *cond, expr->cond_false,
 					  lclass, rclass, ltype, rtype);
@@ -3127,7 +3158,8 @@ static void check_constexpr_scalar_init(struct expr=
ession *orig,
 		}
 		tmp =3D *orig;
 		if (!is_null_pointer_constant(&tmp) &&
-		    !(((sclass & TYPE_PTR) || is_nullptr_type(stype)) && is_zero_const=
ant(&tmp)))
+		    !(((sclass & TYPE_PTR) || is_nullptr_type(stype)) &&
+		      is_zero_constant(&tmp)))
 			sparse_error(orig->pos,
 				     "constexpr pointer initializer is not null");
 		return;
@@ -3309,7 +3341,6 @@ static int handle_initializer(struct expression **e=
p, int nested,
 		struct expression orig;
=20
 		e =3D handle_scalar(e, nested, class, ctype);
-
 		if (!e)
 			return 0;
 		*ep =3D e;
@@ -3323,11 +3354,11 @@ static int handle_initializer(struct expression *=
*ep, int nested,
 		 * shall be constant expressions or a string literal [6.7.8(4)].
 		 */
 		mods |=3D ctype->ctype.modifiers;
-		if (mods & MOD_CONSTEXPR)
+		if (mods & MOD_CONSTEXPR) {
 			check_constexpr_scalar_init(&orig, ctype);
-		else if ((mods & (MOD_TOPLEVEL | MOD_STATIC | MOD_TLS)) &&
-			 valid_type(ctype->ctype.base_type) &&
-			 !(e->flags & (CEF_ACE | CEF_ADDR))) {
+		} else if ((mods & (MOD_TOPLEVEL | MOD_STATIC | MOD_TLS)) &&
+			   valid_type(ctype->ctype.base_type) &&
+			   !(e->flags & (CEF_ACE | CEF_ADDR))) {
 			if (standard >=3D STANDARD_C23)
 				sparse_error(e->pos, "non-constant initializer for static object");
 			else if (Wconstexpr_not_const)
@@ -4187,6 +4218,41 @@ void check_duplicates(struct symbol *sym)
 	}
 }
=20
+static void evaluate_cleanup(struct symbol *sym)
+{
+	struct expression *var_expr, *addr_expr, *fn_expr, *call;
+
+	if (!sym->cleanup || sym->cleanup->type !=3D EXPR_SYMBOL)
+		return;
+
+	if (sym->ctype.modifiers & (MOD_TOPLEVEL | MOD_STATIC | MOD_EXTERN)) {
+		sparse_error(sym->pos, "cleanup attribute may only be applied to local=
 variables");
+		sym->cleanup =3D NULL;
+		return;
+	}
+
+	var_expr =3D alloc_expression(sym->pos, EXPR_SYMBOL);
+	var_expr->symbol =3D sym;
+	var_expr->symbol_name =3D sym->ident;
+	evaluate_expression(var_expr);
+
+	addr_expr =3D alloc_expression(sym->pos, EXPR_PREOP);
+	addr_expr->op =3D '&';
+	addr_expr->unop =3D var_expr;
+	evaluate_expression(addr_expr);
+
+	fn_expr =3D alloc_expression(sym->cleanup->pos, EXPR_SYMBOL);
+	fn_expr->symbol =3D sym->cleanup->symbol;
+	fn_expr->symbol_name =3D sym->cleanup->symbol_name;
+
+	call =3D alloc_expression(sym->pos, EXPR_CALL);
+	call->fn =3D fn_expr;
+	add_expression(&call->args, addr_expr);
+	evaluate_call(call);
+
+	sym->cleanup =3D call;
+}
+
 static bool check_constexpr_vm_type(struct symbol *type)
 {
 	while (type) {
@@ -4236,41 +4302,6 @@ static bool has_invalid_constexpr_qualifiers(struc=
t symbol *type)
 	return false;
 }
=20
-static void evaluate_cleanup(struct symbol *sym)
-{
-	struct expression *var_expr, *addr_expr, *fn_expr, *call;
-
-	if (!sym->cleanup || sym->cleanup->type !=3D EXPR_SYMBOL)
-		return;
-
-	if (sym->ctype.modifiers & (MOD_TOPLEVEL | MOD_STATIC | MOD_EXTERN)) {
-		sparse_error(sym->pos, "cleanup attribute may only be applied to local=
 variables");
-		sym->cleanup =3D NULL;
-		return;
-	}
-
-	var_expr =3D alloc_expression(sym->pos, EXPR_SYMBOL);
-	var_expr->symbol =3D sym;
-	var_expr->symbol_name =3D sym->ident;
-	evaluate_expression(var_expr);
-
-	addr_expr =3D alloc_expression(sym->pos, EXPR_PREOP);
-	addr_expr->op =3D '&';
-	addr_expr->unop =3D var_expr;
-	evaluate_expression(addr_expr);
-
-	fn_expr =3D alloc_expression(sym->cleanup->pos, EXPR_SYMBOL);
-	fn_expr->symbol =3D sym->cleanup->symbol;
-	fn_expr->symbol_name =3D sym->cleanup->symbol_name;
-
-	call =3D alloc_expression(sym->pos, EXPR_CALL);
-	call->fn =3D fn_expr;
-	add_expression(&call->args, addr_expr);
-	evaluate_call(call);
-
-	sym->cleanup =3D call;
-}
-
 static struct symbol *evaluate_symbol(struct symbol *sym)
 {
 	struct symbol *base_type;
diff --git a/expand.c b/expand.c
index 5c3777ff3a23..1888effa4e37 100644
--- a/expand.c
+++ b/expand.c
@@ -850,6 +850,7 @@ static int expand_conditional(struct expression *expr=
)
=20
 	cond_cost =3D expand_expression(cond);
 	if (cond->type =3D=3D EXPR_VALUE) {
+		struct symbol *ctype =3D expr->ctype;
 		unsigned flags =3D expr->flags;
 		if (!cond->value && !cond->value_hi)
 			valt =3D valf;
@@ -860,13 +861,27 @@ static int expand_conditional(struct expression *ex=
pr)
 		expr->flags =3D flags;
 		if (expr->type =3D=3D EXPR_VALUE)
 			expr->taint |=3D cond->taint;
+		if (ctype =3D=3D &void_ctype && expr->ctype !=3D &void_ctype) {
+			if (expr->type =3D=3D EXPR_VALUE || expr->type =3D=3D EXPR_FVALUE) {
+				expr->type =3D EXPR_VALUE;
+				expr->value =3D 0;
+				expr->ctype =3D &void_ctype;
+			} else {
+				struct expression *sub =3D alloc_expression(expr->pos, expr->type);
+				*sub =3D *expr;
+				expr->type =3D EXPR_CAST;
+				expr->ctype =3D &void_ctype;
+				expr->cast_type =3D &void_ctype;
+				expr->cast_expression =3D sub;
+			}
+		}
 		return cost;
 	}
=20
 	cost =3D expand_expression(valt);
 	cost +=3D expand_expression(valf);
=20
-	if (cost < SELECT_COST) {
+	if (expr->ctype !=3D &void_ctype && cost < SELECT_COST) {
 		expr->type =3D EXPR_SELECT;
 		cost -=3D BRANCH_COST - 1;
 	}
diff --git a/linearize.c b/linearize.c
index 9d36415551d6..9dc2fecfe731 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1699,6 +1699,14 @@ static pseudo_t linearize_short_conditional(struct=
 entrypoint *ep, struct expres
 	bb_false =3D alloc_basic_block(ep, expr_false->pos);
 	merge =3D alloc_basic_block(ep, expr->pos);
=20
+	if (expr->ctype =3D=3D &void_ctype || type_size(expr->ctype) <=3D 0) {
+		linearize_cond_branch(ep, cond, merge, bb_false);
+		set_activeblock(ep, bb_false);
+		linearize_expression(ep, expr_false);
+		set_activeblock(ep, merge);
+		return VOID;
+	}
+
 	src1 =3D linearize_expression(ep, cond);
 	phi1 =3D alloc_phi(ep->active, src1, expr->ctype);
 	add_branch(ep, src1, merge, bb_false);
@@ -1728,6 +1736,17 @@ static pseudo_t linearize_conditional(struct entry=
point *ep, struct expression *
=20
 	linearize_cond_branch(ep, cond, bb_true, bb_false);
=20
+	if (expr->ctype =3D=3D &void_ctype || type_size(expr->ctype) <=3D 0) {
+		set_activeblock(ep, bb_true);
+		linearize_expression(ep, expr_true);
+		add_goto(ep, merge);
+
+		set_activeblock(ep, bb_false);
+		linearize_expression(ep, expr_false);
+		set_activeblock(ep, merge);
+		return VOID;
+	}
+
 	set_activeblock(ep, bb_true);
 	src1 =3D linearize_expression(ep, expr_true);
 	phi1 =3D alloc_phi(ep->active, src1, expr->ctype);
diff --git a/validation/cond-err-expand.c b/validation/cond-err-expand.c
index b52624bc9de5..f24235a22e68 100644
--- a/validation/cond-err-expand.c
+++ b/validation/cond-err-expand.c
@@ -17,15 +17,6 @@ void bar(void)
  * check-name: cond-err-expand.c
  * check-command: test-linearize -Wno-decl $file
  *
- * check-error-start
-cond-err-expand.c:8:11: error: incompatible types in conditional express=
ion (different base types):
-cond-err-expand.c:8:11:    int
-cond-err-expand.c:8:11:    void
-cond-err-expand.c:13:11: error: incompatible types in conditional expres=
sion (different base types):
-cond-err-expand.c:13:11:    void
-cond-err-expand.c:13:11:    int
- * check-error-end
- *
  * check-output-ignore
  * check-output-excludes: call.* __builtin_constant_p
  */
diff --git a/validation/cond-one-void-pedantic.c b/validation/cond-one-vo=
id-pedantic.c
new file mode 100644
index 000000000000..f91254f52c04
--- /dev/null
+++ b/validation/cond-one-void-pedantic.c
@@ -0,0 +1,39 @@
+void *f(void);
+void g(void);
+int h(void);
+extern void *p;
+
+static void test(int c)
+{
+	c ? f() : g();
+	c ? g() : h();
+	c ? 1 : g();
+	c ? p : g();
+	p ?: g();
+	c ? g() : (void)0;		// both sides void: always OK
+	(void)(c ? h() : g());
+}
+
+static int use_value(int c)
+{
+	int x =3D c ? h() : g();		// KO: void value used
+	return x;
+}
+
+/*
+ * check-name: cond-one-void-pedantic
+ * check-command: sparse -Wpedantic $file
+ *
+ * check-error-start
+cond-one-void-pedantic.c:8:11: warning: ISO C forbids conditional expres=
sion with only one void side
+cond-one-void-pedantic.c:9:11: warning: ISO C forbids conditional expres=
sion with only one void side
+cond-one-void-pedantic.c:10:11: warning: ISO C forbids conditional expre=
ssion with only one void side
+cond-one-void-pedantic.c:11:11: warning: ISO C forbids conditional expre=
ssion with only one void side
+cond-one-void-pedantic.c:12:11: warning: ISO C forbids conditional expre=
ssion with only one void side
+cond-one-void-pedantic.c:14:18: warning: ISO C forbids conditional expre=
ssion with only one void side
+cond-one-void-pedantic.c:19:19: warning: ISO C forbids conditional expre=
ssion with only one void side
+cond-one-void-pedantic.c:19:19: warning: incorrect type in initializer (=
different base types)
+cond-one-void-pedantic.c:19:19:    expected int x
+cond-one-void-pedantic.c:19:19:    got void
+ * check-error-end
+ */
diff --git a/validation/cond-one-void.c b/validation/cond-one-void.c
new file mode 100644
index 000000000000..6034dbb218a9
--- /dev/null
+++ b/validation/cond-one-void.c
@@ -0,0 +1,47 @@
+void *f(void);
+void g(void);
+int h(void);
+extern void *p;
+
+static void test(int c)
+{
+	c ? f() : g();
+	c ? g() : h();
+	c ? 1 : g();
+	c ? p : g();
+	p ?: g();
+	1 ?: g();
+	0 ?: g();
+	c ? g() : (void)0;		// both sides void: always OK
+	(void)(c ? h() : g());
+}
+
+struct empty {};
+struct incomplete;
+extern struct empty emp;
+extern struct incomplete inc;
+
+static int use_value(int c)
+{
+	int x =3D c ? h() : g();		// KO: void value used
+	int y =3D 1 ?: g();		// KO: void value used
+	c ? (void)0 : emp;		// OK: complete empty struct
+	c ? (void)0 : inc;		// KO: incomplete type
+	return x + y;
+}
+
+/*
+ * check-name: cond-one-void
+ * check-description: Like gcc and clang, accept conditional expressions
+ *	with only one void side and give these type void.
+ *
+ * check-error-start
+cond-one-void.c:26:19: warning: incorrect type in initializer (different=
 base types)
+cond-one-void.c:26:19:    expected int x
+cond-one-void.c:26:19:    got void
+cond-one-void.c:27:19: warning: incorrect type in initializer (different=
 base types)
+cond-one-void.c:27:19:    expected int y
+cond-one-void.c:27:19:    got void
+cond-one-void.c:29:11: error: expression has incomplete type 'struct inc=
omplete'
+ * check-error-end
+ */
diff --git a/validation/linear/cond-one-void.c b/validation/linear/cond-o=
ne-void.c
new file mode 100644
index 000000000000..6c962809736f
--- /dev/null
+++ b/validation/linear/cond-one-void.c
@@ -0,0 +1,24 @@
+void *f(void);
+void g(void);
+int h(void);
+
+void test_cond_void_ir(int c, void *p)
+{
+	c ? f() : g();
+	c ? g() : h();
+	c ? 1 : g();
+	p ?: g();
+	1 ?: g();
+	0 ?: g();
+}
+
+/*
+ * check-name: cond-one-void-linearize
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-excludes: VOID
+ * check-output-excludes: phi\\.
+ * check-output-excludes: phisrc\\.
+ * check-output-excludes: select\\.
+ */

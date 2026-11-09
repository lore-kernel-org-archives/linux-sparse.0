Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256418;
	b=XGbwOcXJhbZTygpifXf03iQgwZaBrIM5ez3r8hb4G83GfpAyyc9BfX44cGMtkPVh50Kn
	 yHAGou/i3oiqpChsimjZ9e5GsNca2vRj/LEaHWJmMfKxZ3yCsoZhWlfqnC1Jlc+r28f2D
	 q5ocVZ0f8qI0z4NEysvT4egWxp5k3W/uON9uet1n5t9kvWRYKPdMYDqGLHJgvFdO29dFk
	 TTqY0Cw0+6fiFqauUlVIJOtMEXg0nUe6vKBddaczSjC5PAYIbUjvI5GEPVj5/8UAsBwyG
	 d9S7OBEf7/e6KVKekbW1Cp3yCvnmw4+gxCNyvyiTdeyKFdimHCREgujuir+eW4PeBFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256418;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=6xXw6fO090kxJ2m2VEfKOCGFj3ofwgnANLkMiF63dpw=;
	b=Ufyf50oeeLCBWHn/q2eYKcAqAN7LEIlE8BpJxny7/nFSrliUe3m/3mxlwndSYUpQKWic
	 eeL2RbD+z4zM/8xSR6L91J5tsaM3+Jldj7QDguhx+1X5qkdNyJ068yaI3iLDVCkvEXc9p
	 PmSPPEeVEkqzwcjwBMAP7PlEO9cgKLKfhojo+RBZGyIQ4Wx7bzHkEFelpAn9/N2cCPH16
	 xgpfVPbvSuYfeePavXujEg2H5WIX9WZNiOwKTyQmdvXUNjyUUCAAv9fkAoon3bMBZ86Cd
	 bXNkidyB4g0Iq0Z3Dy8hKV5x1jZRfop/SmLobZSi6rZlYZN6SiCxIbQ3ZCq0drSe29g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=dFApaWnR;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8F4606A326
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E8F4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=dFApaWnR
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhM40Dzqz1XMYJq;
	Mon,  9 Nov 2026 20:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256411; x=1796848412; bh=6xXw6
	fO090kxJ2m2VEfKOCGFj3ofwgnANLkMiF63dpw=; b=dFApaWnRVlC68xmhKzdDC
	M3HA36Uv0zvb8IyUp9pHAeBumNfSXcOggBAUbpZ48usriuylAe+YjarhMIXTgBr3
	n472ShzagW0WEZRM+Rm7J9hd3oaziQyVBRO8R7qm5hlemfWD7LgZeVPdSUz1b04o
	QFALLkUboS9HGbegyWq3t5kCIg08qCpPj1ccEQY7wTQEuZOZzAkvyLoIvsSY1R/c
	60WqP5K+DRKg5GwVpYet7cHJXt6T2hTUi6ubMSc53dUlKoUYt3D4ySsbxdnrXAhb
	1TMgD3Lj6+dg9vsZPfMvEZ2vH00SRqEMP6JhHRO/XHaznd7Ov8N3wH9Aztp5yVCt
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id aVma_x58FkBv; Mon,  9 Nov 2026 20:33:31 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLv2sSxz1XLwXP;
	Mon,  9 Nov 2026 20:33:27 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 14/73] inline: Copy union cast types and VLA bounds when inlining
Date: Mon,  9 Nov 2026 12:32:00 -0800
Message-ID: <20261109203259.362845-15-bvanassche@acm.org>
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

Duplicate union EXPR_CAST target symbols and clone variable-length array
SYM_ARRAY chains in inline.c so that union casts and VLA dimension
expressions inside inlined functions do not share or mutate symbols
across call sites.

Add regression tests in validation/eval-expand-inline-fixes.c and
validation/eval-ptr-incomplete-and-inline.c.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 inline.c                                    | 101 ++++++++++++++++++--
 validation/eval-expand-inline-fixes.c       |  49 ++++++++++
 validation/eval-ptr-incomplete-and-inline.c |  70 ++++++++++++++
 3 files changed, 213 insertions(+), 7 deletions(-)
 create mode 100644 validation/eval-expand-inline-fixes.c
 create mode 100644 validation/eval-ptr-incomplete-and-inline.c

diff --git a/inline.c b/inline.c
index a7ab73d37492..1948bea52ffb 100644
--- a/inline.c
+++ b/inline.c
@@ -35,6 +35,7 @@
 #include "evaluate.h"
=20
 static void copy_statement(struct statement *src, struct statement *dst)=
;
+static struct expression *copy_expression(struct expression *expr);
=20
 static struct expression * dup_expression(struct expression *expr)
 {
@@ -63,6 +64,64 @@ static struct symbol *copy_symbol(struct position pos,=
 struct symbol *sym)
 	return sym->replace;
 }
=20
+static struct symbol *copy_type(struct symbol *type)
+{
+	if (!type)
+		return NULL;
+	switch (type->type) {
+	case SYM_NODE: {
+		struct symbol *base =3D copy_type(type->ctype.base_type);
+		struct symbol *n;
+		if (base =3D=3D type->ctype.base_type)
+			return type;
+		n =3D alloc_symbol(type->pos, SYM_NODE);
+		*n =3D *type;
+		n->ctype.base_type =3D base;
+		if (base && base->bit_size < 0)
+			n->examined =3D 0;
+		return n;
+	}
+	case SYM_ARRAY: {
+		struct symbol *elem =3D copy_type(type->ctype.base_type);
+		struct expression *size =3D copy_expression(type->array_size);
+		struct symbol *arr;
+		if (elem =3D=3D type->ctype.base_type && size =3D=3D type->array_size =
&& !type->array_size)
+			return type;
+		arr =3D alloc_symbol(type->pos, SYM_ARRAY);
+		*arr =3D *type;
+		arr->ctype.base_type =3D elem;
+		arr->array_size =3D size;
+		if (type->array_size || elem !=3D type->ctype.base_type)
+			arr->examined =3D 0;
+		return arr;
+	}
+	case SYM_PTR: {
+		struct symbol *base =3D copy_type(type->ctype.base_type);
+		struct symbol *ptr;
+		if (base =3D=3D type->ctype.base_type)
+			return type;
+		ptr =3D alloc_symbol(type->pos, SYM_PTR);
+		*ptr =3D *type;
+		ptr->ctype.base_type =3D base;
+		return ptr;
+	}
+	case SYM_TYPEOF:
+	case SYM_TYPEOF_UNQUAL: {
+		struct expression *init =3D copy_expression(type->initializer);
+		struct symbol *t;
+		if (init =3D=3D type->initializer)
+			return type;
+		t =3D alloc_symbol(type->pos, type->type);
+		*t =3D *type;
+		t->initializer =3D init;
+		t->examined =3D 0;
+		return t;
+	}
+	default:
+		return type;
+	}
+}
+
 static struct symbol_list *copy_symbol_list(struct symbol_list *src)
 {
 	struct symbol_list *dst =3D NULL;
@@ -155,11 +214,19 @@ static struct expression * copy_expression(struct e=
xpression *expr)
=20
 	/* Cast/sizeof/__alignof__ */
 	case EXPR_CAST:
-		if (!expr->cast_expression)
-			return NULL;
-		if (expr->cast_expression->type =3D=3D EXPR_INITIALIZER) {
+		if (!expr->cast_expression) {
+			struct symbol *cast_type =3D copy_type(expr->cast_type);
+			if (cast_type !=3D expr->cast_type) {
+				expr =3D dup_expression(expr);
+				expr->cast_type =3D cast_type;
+			}
+			return expr;
+		}
+		if (expr->cast_expression->type =3D=3D EXPR_INITIALIZER ||
+		    (expr->cast_type && expr->cast_type->ctype.base_type &&
+		     expr->cast_type->ctype.base_type->type =3D=3D SYM_UNION)) {
 			struct expression *cast =3D expr->cast_expression;
-			struct symbol *sym =3D expr->cast_type;
+			struct symbol *sym =3D copy_type(expr->cast_type);
 			expr =3D dup_expression(expr);
 			expr->cast_expression =3D copy_expression(cast);
 			expr->cast_type =3D alloc_symbol(sym->pos, sym->type);
@@ -172,10 +239,12 @@ static struct expression * copy_expression(struct e=
xpression *expr)
 	case EXPR_PTRSIZEOF:
 	case EXPR_ALIGNOF: {
 		struct expression *cast =3D copy_expression(expr->cast_expression);
-		if (cast =3D=3D expr->cast_expression)
+		struct symbol *cast_type =3D copy_type(expr->cast_type);
+		if (cast =3D=3D expr->cast_expression && cast_type =3D=3D expr->cast_t=
ype)
 			break;
 		expr =3D dup_expression(expr);
 		expr->cast_expression =3D cast;
+		expr->cast_type =3D cast_type;
 		break;
 	}
=20
@@ -343,8 +412,10 @@ static struct statement *copy_one_statement(struct s=
tatement *stmt)
 		newstmt->declaration =3D NULL;
 		FOR_EACH_PTR(stmt->declaration, sym) {
 			struct symbol *newsym =3D copy_symbol(stmt->pos, sym);
-			if (newsym !=3D sym)
+			if (newsym !=3D sym) {
+				newsym->ctype.base_type =3D copy_type(newsym->ctype.base_type);
 				newsym->initializer =3D copy_expression(sym->initializer);
+			}
 			add_symbol(&newstmt->declaration, newsym);
 		} END_FOR_EACH_PTR(sym);
 		stmt =3D newstmt;
@@ -424,10 +495,20 @@ static struct statement *copy_one_statement(struct =
statement *stmt)
 		break;	=09
 	}
 	case STMT_ITERATOR: {
+		struct symbol_list *old_syms =3D stmt->iterator_syms;
+		struct symbol *sym;
 		stmt =3D dup_statement(stmt);
 		stmt->iterator_break =3D copy_symbol(stmt->pos, stmt->iterator_break);
 		stmt->iterator_continue =3D copy_symbol(stmt->pos, stmt->iterator_cont=
inue);
-		stmt->iterator_syms =3D copy_symbol_list(stmt->iterator_syms);
+		stmt->iterator_syms =3D NULL;
+		FOR_EACH_PTR(old_syms, sym) {
+			struct symbol *newsym =3D copy_symbol(stmt->pos, sym);
+			if (newsym !=3D sym) {
+				newsym->ctype.base_type =3D copy_type(newsym->ctype.base_type);
+				newsym->initializer =3D copy_expression(sym->initializer);
+			}
+			add_symbol(&stmt->iterator_syms, newsym);
+		} END_FOR_EACH_PTR(sym);
=20
 		stmt->iterator_pre_statement =3D copy_one_statement(stmt->iterator_pre=
_statement);
 		stmt->iterator_pre_condition =3D copy_expression(stmt->iterator_pre_co=
ndition);
@@ -542,6 +623,8 @@ int inline_function(struct expression *expr, struct s=
ymbol *sym)
=20
 		if (name) {
 			*a =3D *name;
+			a->bb_target =3D NULL;
+			a->pseudo =3D NULL;
 			set_replace(name, a);
 			add_symbol(&fn_symbol_list, a);
 			a->initializer =3D arg;
@@ -557,6 +640,10 @@ int inline_function(struct expression *expr, struct =
symbol *sym)
 	} END_FOR_EACH_PTR(arg);
 	FINISH_PTR_LIST(name);
=20
+	FOR_EACH_PTR(arg_decl, name) {
+		name->ctype.base_type =3D copy_type(name->ctype.base_type);
+	} END_FOR_EACH_PTR(name);
+
 	copy_statement(fn->inline_stmt, stmt);
=20
 	if (arg_decl) {
diff --git a/validation/eval-expand-inline-fixes.c b/validation/eval-expa=
nd-inline-fixes.c
new file mode 100644
index 000000000000..95600c32ec93
--- /dev/null
+++ b/validation/eval-expand-inline-fixes.c
@@ -0,0 +1,49 @@
+/* 1. _Generic array/function decay and qualifier stripping */
+extern int arr[4];
+extern int fn(void);
+const int ci =3D 0;
+
+_Static_assert(_Generic(arr, int *: 1, default: 0) =3D=3D 1, "array deca=
y");
+_Static_assert(_Generic(fn, int (*)(void): 1, default: 0) =3D=3D 1, "fun=
c decay");
+_Static_assert(_Generic(ci, int: 1, const int: 0) =3D=3D 1, "qual strip"=
);
+
+/* 2. Inlining function with cleanup attribute and _Static_assert */
+void cl(int *p);
+
+static inline int inl_cleanup(int v)
+{
+	_Static_assert(sizeof(v) =3D=3D sizeof(int), "int size");
+	int x __attribute__((cleanup(cl))) =3D v;
+	return x + 1;
+}
+
+int call_inl(int v)
+{
+	return inl_cleanup(v);
+}
+
+/* 3. Conditional operator preserving noderef qualifier */
+#define __noderef __attribute__((noderef))
+void cond_noderef(void *vp, int __noderef *p)
+{
+	int *q =3D (1 ? vp : p);
+	(void)q;
+}
+
+/* 4. Signed division overflow in constant expression */
+int div_ovf(void)
+{
+	return (-9223372036854775807LL - 1LL) / -1LL;
+}
+
+/*
+ * check-name: eval-expand-inline-fixes
+ * check-command: sparse -Wno-decl $file
+ *
+ * check-error-start
+eval-expand-inline-fixes.c:29:21: warning: incorrect type in initializer=
 (different modifiers)
+eval-expand-inline-fixes.c:29:21:    expected int *q
+eval-expand-inline-fixes.c:29:21:    got void [noderef] *
+eval-expand-inline-fixes.c:36:47: warning: constant integer operation ov=
erflow
+ * check-error-end
+ */
diff --git a/validation/eval-ptr-incomplete-and-inline.c b/validation/eva=
l-ptr-incomplete-and-inline.c
new file mode 100644
index 000000000000..fb1c7b71496b
--- /dev/null
+++ b/validation/eval-ptr-incomplete-and-inline.c
@@ -0,0 +1,70 @@
+/* 1. Subtraction of pointers to incomplete type */
+extern int arr[];
+static int test_sub(int (*p)[], int (*q)[])
+{
+	return p - q;
+}
+
+/* 2. _Alignof on incomplete type (void) */
+static unsigned long test_align(void)
+{
+	return _Alignof(void);
+}
+
+/* 3. Float <-> unsigned integer constant folding in initializers */
+static unsigned int u =3D (unsigned int)3.8f;
+static float f =3D 4000000000U;
+
+/* 4. Unsigned pointer arithmetic */
+static char *test_ptr_add(char *p)
+{
+	return p + 0x80000000U;
+}
+
+/* 5. Named asm constraint */
+static int test_asm_named(int val)
+{
+	int out;
+	asm("mov %0, %[in]" : "=3Dr"(out) : [in] "r"(val));
+	return out;
+}
+
+/* 6. Inlining with local array and union cast */
+union U { int x; float y; };
+static inline int inl_func(int v)
+{
+	int a[4] =3D { v, 1, 2, 3 };
+	union U u =3D (union U)v;
+	return a[0] + u.x;
+}
+static int call_inl(int x, int y)
+{
+	return inl_func(x) + inl_func(y);
+}
+
+/* 7. Inlining multi-dimensional VLAs, VLA pointers, and typeof(VLA) */
+static inline unsigned long inl_vla(int n, int m)
+{
+	int mat[n][m];
+	int (*p)[m] =3D mat;
+	typeof(mat) mat2;
+
+	for (int row[n], k =3D 0; k < 1; k++)
+		row[0] =3D n;
+	return sizeof(mat) + sizeof(*p) + sizeof(mat2) + sizeof(int [n][m]);
+}
+
+static unsigned long call_inl_vla(int a, int b, int c, int d)
+{
+	return inl_vla(a, b) + inl_vla(c, d);
+}
+
+/*
+ * check-name: eval-ptr-incomplete-and-inline
+ * check-command: sparse -Wno-vla $file
+ *
+ * check-error-start
+eval-ptr-incomplete-and-inline.c:5:18: error: subtraction of pointers to=
 incomplete type
+eval-ptr-incomplete-and-inline.c:11:16: error: cannot size alignment of =
incomplete type
+ * check-error-end
+ */

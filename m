Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256435;
	b=CbzZo6Vt9KNK+JY69B/8ctiC4h1Ywll9VEYKrOzcrn7ha2QVnz1GRRgYNPp8ZpMFeEQT
	 /4c8P9LL3hDQrhWmxvPowfcbeIf11s1wStUaNzMT9NgFS2IndHSlFE4GsLOgMPC+XlluM
	 CfTk6GEU+B12u2YMXhf4d8uIYs9aFYRw4XRFm1qnMVJNqBPvw+0J88nF26Qct611Wdcxm
	 S1G062IhO3aTE2IMG1/kC5pwr9QvC97UrRfA2OtebPOiQxF65czE3rh42ol/SpWPhkrnV
	 h/TjQ/qcoJG3TOuiDgNjFlByDonXWPARkQ6qUjXmlQvIhLo4TAGsVKQ3dCq3sBtUSnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=cFzzwqkT6aGjpDLFHBEsDDaK8ZYcn9pMCM13EZzyhvk=;
	b=pswqQ6Xn9voINdAHQ/Dimb+KMIsyj9iETrcVa7gCg85irwjsbCLSFkgAV7h5ObxpWFyR
	 JRkUefCruodcihZAIS7+VsMgZ1OAWKvIzxydcpWicHvwghwW2hHUNqTNu/ErOcO4eaXR/
	 LDGnruIVRa5rIHNGQfTkTnW6TsI8bv5pxJU5QbDijk7eWlEMNEp8OFia6ue38dMLxDw3F
	 DtS0e0T5PWFj+deVMH0/woV6rLkzzKScjtunlX00eSAlEbJyTU9OYif3sMClMjJXYPiPS
	 K53FWVOq0Tdxl7/oL6F6OjwdDkauR7dr93txaFtMLT1QsV5PaY93hfODzvoDvZrXGPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=wAjAL0o3;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C500606A32A
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C500606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=wAjAL0o3
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhMH0yT8z1XM5kD;
	Mon,  9 Nov 2026 20:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256417; x=1796848418; bh=cFzzw
	qkT6aGjpDLFHBEsDDaK8ZYcn9pMCM13EZzyhvk=; b=wAjAL0o3LxW6Qx9AINeYH
	VK/jv46XRQBzezIjusW2Xpeas9PlyTDceekFmRJE72dYyAbIy35KksoggqlohZgi
	eCK5HArdlGGW4SpUYOEksrk4wlJ79NLOSVOPosAsRPlI4VsjfL5nl120uImvIBcv
	chMRdTsa+uiOTr6PuiQcBMEW4EEH+8A/gIoNwotk9IXKXnl7HFkIzsCxDwh3CRzo
	IyD26QgxaSyrhDsrdmStui6NBIuW6zXqMUUybGH8IVpqGyGTmwxNGkFUaZRdufPV
	3/FmjE+cq0+7LYBiRdjWN8Sq/uzUrDVUTfBI76EPc5XseO+UDWA8QFeSnmkRGlAG
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Kg1qofjSFKFj; Mon,  9 Nov 2026 20:33:37 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM42HMxz1XMYJN;
	Mon,  9 Nov 2026 20:33:36 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 54/73] c23: Support empty initializer braces {}
Date: Mon,  9 Nov 2026 12:32:40 -0800
Message-ID: <20261109203259.362845-55-bvanassche@acm.org>
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

Support empty initializer braces '{}' for scalar, pointer, nullptr_t,
aggregate, union, and variable-length array objects and compound literals
in C23 mode per ISO C23 6.7.11:
- Synthesize zero/null scalar initializers in handle_scalar() without
  emitting spurious nested scalar-brace warnings, and keep warning under
  -Wpedantic before C23.
- Preserve runtime bounds on VLA empty initializers ('int vla[n] =3D {}')
  and reject empty initializers for incomplete arrays ('int a[] =3D {}')
  and incomplete structs or unions.
- Lower empty aggregate and null-pointer static initializers cleanly in
  linearize and sparse-llvm.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 evaluate.c                           |  23 +++++-
 linearize.c                          |   2 +-
 parse.c                              |   5 ++
 sparse-llvm.c                        | 114 +++++++++++++++++++--------
 symbol.c                             |   6 ++
 validation/backend/c23-empty-init.c  |  24 ++++++
 validation/c23-auto-error.c          |   5 +-
 validation/c23-constexpr-error.c     |   2 +-
 validation/c23-empty-init-error.c    |  19 +++++
 validation/c23-empty-init-pedantic.c |  14 ++++
 validation/c23-empty-init.c          |  64 +++++++++++++++
 11 files changed, 239 insertions(+), 39 deletions(-)
 create mode 100644 validation/backend/c23-empty-init.c
 create mode 100644 validation/c23-empty-init-error.c
 create mode 100644 validation/c23-empty-init-pedantic.c
 create mode 100644 validation/c23-empty-init.c

diff --git a/evaluate.c b/evaluate.c
index 43ad5f59b860..f40e35773639 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2987,7 +2987,8 @@ static int is_string_literal(struct expression **v)
  * an effect of screwup).  In case of anything not legal, we are definit=
ely
  * having an effect of screwup, so just fail and let the caller warn.
  */
-static struct expression *handle_scalar(struct expression *e, int nested=
)
+static struct expression *handle_scalar(struct expression *e, int nested=
,
+					int class, struct symbol *ctype)
 {
 	struct expression *v =3D NULL, *p;
 	int count =3D 0;
@@ -3001,6 +3002,19 @@ static struct expression *handle_scalar(struct exp=
ression *e, int nested)
 			v =3D p;
 		count++;
 	} END_FOR_EACH_PTR(p);
+	if (count =3D=3D 0) {
+		if (standard >=3D STANDARD_C23) {
+			v =3D alloc_const_expression(e->pos, 0);
+			if (class & TYPE_PTR)
+				v->ctype =3D &null_ctype;
+			else if (is_nullptr_type(ctype)) {
+				v->ctype =3D &nullptr_ctype;
+				v->flags =3D CEF_ADDR;
+			}
+			return v;
+		}
+		return NULL;
+	}
 	if (count !=3D 1)
 		return NULL;
 	switch(v->type) {
@@ -3202,7 +3216,7 @@ static int handle_initializer(struct expression **e=
p, int nested,
 	if (!(class & TYPE_COMPOUND)) {
 		struct expression orig;
=20
-		e =3D handle_scalar(e, nested);
+		e =3D handle_scalar(e, nested, class, ctype);
=20
 		if (!e)
 			return 0;
@@ -3302,6 +3316,11 @@ static void evaluate_initializer(struct symbol *ct=
ype, struct expression **ep)
 {
 	struct symbol *type;
 	int class =3D classify_type(ctype, &type);
+	if ((type->type =3D=3D SYM_STRUCT || type->type =3D=3D SYM_UNION) &&
+	    (type->bit_size < 0 || !type->endpos.line)) {
+		expression_error(*ep, "initializer for incomplete type");
+		return;
+	}
 	if (!handle_initializer(ep, 0, class, ctype, 0))
 		expression_error(*ep, "invalid initializer");
 }
diff --git a/linearize.c b/linearize.c
index 4179aea03af1..268466f07886 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2003,7 +2003,7 @@ static pseudo_t linearize_one_symbol(struct entrypo=
int *ep, struct symbol *sym)
 	sym->initialized =3D 1;
 	ad.address =3D symbol_pseudo(ep, sym);
=20
-	if (sym->initializer && !is_scalar_type(sym)) {
+	if (sym->initializer && !is_scalar_type(sym) && sym->bit_size > 0) {
 		// default zero initialization [6.7.9.21]
 		// FIXME: this init the whole aggregate while
 		// only the existing fields need to be initialized.
diff --git a/parse.c b/parse.c
index 13b8cf5d43c1..f49b3f188c69 100644
--- a/parse.c
+++ b/parse.c
@@ -3456,6 +3456,11 @@ struct token *initializer(struct expression **tree=
, struct token *token)
 		}
=20
 		token =3D initializer_list(&expr->expr_list, token->next);
+		if (ptr_list_empty((struct ptr_list *)expr->expr_list)) {
+			if (standard < STANDARD_C23 && Wpedantic)
+				warning(expr->pos,
+					"ISO C forbids empty initializer braces before C23");
+		}
 		return expect(token, '}', "at end of initializer");
 	}
 	return assignment_expression(token, tree);
diff --git a/sparse-llvm.c b/sparse-llvm.c
index c7055238ff88..f3f6b7e01171 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -309,6 +309,8 @@ static const char *pseudo_name(pseudo_t pseudo, char =
*buf)
 	return buf;
 }
=20
+static LLVMValueRef output_data(LLVMModuleRef module, struct symbol *sym=
);
+
 static LLVMValueRef get_sym_value(LLVMModuleRef module, struct symbol *s=
ym)
 {
 	const char *name =3D show_ident(sym->ident);
@@ -1250,6 +1252,83 @@ static void output_fn(LLVMModuleRef module, struct=
 entrypoint *ep)
 	LLVMDisposeBuilder(function.builder);
 }
=20
+static LLVMValueRef expr_to_const_val(LLVMModuleRef module, struct symbo=
l *sym,
+				      struct expression *initializer)
+{
+	LLVMTypeRef dtype =3D symbol_type(sym);
+
+	if (!initializer)
+		return LLVMConstNull(dtype);
+
+	switch (initializer->type) {
+	case EXPR_VALUE:
+		return constant_value(initializer->value, dtype);
+	case EXPR_FVALUE:
+		return LLVMConstReal(dtype, initializer->fvalue);
+	case EXPR_SYMBOL: {
+		struct symbol *isym =3D initializer->symbol;
+
+		if (!isym->ident) {
+			if (!isym->aux) {
+				expand_symbol(isym);
+				isym->aux =3D output_data(module, isym);
+			}
+			return isym->aux;
+		}
+		LLVMValueRef gv =3D LLVMGetNamedGlobal(module, show_ident(isym->ident)=
);
+		if (!gv)
+			gv =3D output_data(module, isym);
+		return gv;
+	}
+	case EXPR_STRING: {
+		const char *s =3D initializer->string->data;
+		size_t len =3D initializer->string->length;
+
+		return const_string(s, len);
+	}
+	case EXPR_INITIALIZER: {
+		if (ptr_list_empty((struct ptr_list *)initializer->expr_list))
+			return LLVMConstNull(dtype);
+		if (is_array_type(sym)) {
+			struct symbol *arr =3D sym->type =3D=3D SYM_NODE ? sym->ctype.base_ty=
pe : sym;
+			struct symbol *elem_sym =3D arr->ctype.base_type;
+			LLVMTypeRef elem_type =3D symbol_type(elem_sym);
+			unsigned int elem_bytes =3D bits_to_bytes(elem_sym->bit_size);
+			unsigned int nr =3D elem_bytes ? bits_to_bytes(sym->bit_size) / elem_=
bytes : 0;
+			struct expression *entry;
+			LLVMValueRef *vals;
+			LLVMValueRef res;
+			unsigned int i;
+
+			if (!nr)
+				return LLVMConstNull(dtype);
+			vals =3D calloc(nr, sizeof(*vals));
+			for (i =3D 0; i < nr; i++)
+				vals[i] =3D LLVMConstNull(elem_type);
+			FOR_EACH_PTR(initializer->expr_list, entry) {
+				if (entry->type =3D=3D EXPR_POS) {
+					unsigned int idx =3D entry->init_offset / elem_bytes;
+					if (idx < nr) {
+						LLVMValueRef v =3D expr_to_const_val(module, elem_sym,
+										   entry->init_expr);
+						if (v)
+							vals[idx] =3D v;
+					}
+				}
+			} END_FOR_EACH_PTR(entry);
+			res =3D LLVMConstArray(elem_type, vals, nr);
+			free(vals);
+			return res;
+		}
+		warning(initializer->pos, "can't initialize type: %s", show_typename(s=
ym));
+		return NULL;
+	}
+	default:
+		warning(initializer->pos, "can't initialize type: %s", show_typename(s=
ym));
+		return NULL;
+	}
+}
+
 static LLVMValueRef output_data(LLVMModuleRef module, struct symbol *sym=
)
 {
 	struct expression *initializer =3D sym->initializer;
@@ -1257,40 +1336,7 @@ static LLVMValueRef output_data(LLVMModuleRef modu=
le, struct symbol *sym)
 	LLVMValueRef data;
 	const char *name;
=20
-	if (initializer) {
-		switch (initializer->type) {
-		case EXPR_VALUE:
-			initial_value =3D constant_value(initializer->value, symbol_type(sym)=
);
-			break;
-		case EXPR_FVALUE:
-			initial_value =3D LLVMConstReal(symbol_type(sym), initializer->fvalue=
);
-			break;
-		case EXPR_SYMBOL: {
-			struct symbol *sym =3D initializer->symbol;
-
-			initial_value =3D LLVMGetNamedGlobal(module, show_ident(sym->ident));
-			if (!initial_value)
-				initial_value =3D output_data(module, sym);
-			break;
-		}
-		case EXPR_STRING: {
-			const char *s =3D initializer->string->data;
-			size_t len =3D initializer->string->length;
-
-			initial_value =3D const_string(s, len);
-			break;
-		}
-		default:
-			warning(initializer->pos, "can't initialize type: %s", show_typename(=
sym));
-			initial_value =3D NULL;
-			break;
-		}
-	} else {
-		LLVMTypeRef type =3D symbol_type(sym);
-
-		initial_value =3D LLVMConstNull(type);
-	}
-
+	initial_value =3D expr_to_const_val(module, sym, initializer);
 	if (!initial_value)
 		return NULL;
=20
diff --git a/symbol.c b/symbol.c
index 28fa12352569..270e91d9c480 100644
--- a/symbol.c
+++ b/symbol.c
@@ -569,6 +569,12 @@ static struct symbol * examine_node_type(struct symb=
ol *sym)
 			struct symbol *node_type =3D base_type->ctype.base_type;
 			int count =3D count_array_initializer(node_type, initializer);
=20
+			if (standard >=3D STANDARD_C23 &&
+			    initializer->type =3D=3D EXPR_INITIALIZER &&
+			    ptr_list_empty((struct ptr_list *)initializer->expr_list))
+				sparse_error(sym->pos,
+					     "empty initializer for incomplete array");
+
 			if (node_type && node_type->bit_size >=3D 0)
 				bit_size =3D implicit_array_size(sym, count);
 		}
diff --git a/validation/backend/c23-empty-init.c b/validation/backend/c23=
-empty-init.c
new file mode 100644
index 000000000000..e8741bd5d79a
--- /dev/null
+++ b/validation/backend/c23-empty-init.c
@@ -0,0 +1,24 @@
+typedef typeof(nullptr) nullptr_t;
+
+struct s {
+	int a;
+	void *p;
+};
+
+static nullptr_t g_np =3D {};
+static void *g_ptr =3D {};
+static struct s g_s =3D {};
+
+int test_vla_empty(int n);
+int test_vla_empty(int n)
+{
+	int vla[n] =3D {};
+	return vla[0] + g_s.a + (g_np !=3D nullptr) + (g_ptr !=3D nullptr);
+}
+
+/*
+ * check-name: backend-c23-empty-init
+ * check-command: sparse-llvm-dis -m64 -std=3Dc23 -Wno-vla $file
+ * check-output-ignore
+ * check-output-contains: define i32 @test_vla_empty(
+ */
diff --git a/validation/c23-auto-error.c b/validation/c23-auto-error.c
index b88ebd37d2d9..16d9c85beb40 100644
--- a/validation/c23-auto-error.c
+++ b/validation/c23-auto-error.c
@@ -28,10 +28,12 @@ void block_errors(void)
 	int bad_cast =3D (auto)1;
 	_Atomic(auto) bad_atomic =3D 1;
 	auto braced =3D { 1 };
+	auto empty =3D {};
 	(void)bad_sz;
 	(void)bad_cast;
 	(void)bad_atomic;
 	(void)braced;
+	(void)empty;
 }
=20
 /*
@@ -56,6 +58,7 @@ c23-auto-error.c:29:16: error: Trying to use reserved w=
ord 'auto' as identifier
 c23-auto-error.c:29:23: error: Expected ; at end of declaration
 c23-auto-error.c:29:23: error: got bad_atomic
 c23-auto-error.c:30:14: error: auto requires a scalar initializer expres=
sion
+c23-auto-error.c:31:14: error: auto requires a scalar initializer expres=
sion
 c23-auto-error.c:2:15: error: invalid initializer
 c23-auto-error.c:7:13: error: underspecified symbol 'self' used in its o=
wn initializer
 c23-auto-error.c:9:18: error: underspecified symbol 'self_expr' used in =
its own initializer
@@ -63,6 +66,6 @@ c23-auto-error.c:10:23: error: underspecified symbol 's=
elf_sz' used in its own i
 c23-auto-error.c:10:16: error: cannot size expression
 c23-auto-error.c:25:31: error: underspecified symbol 'shadow' used in it=
s own initializer
 c23-auto-error.c:27:22: error: cannot size expression
-c23-auto-error.c:33:15: error: undefined identifier 'bad_atomic'
+c23-auto-error.c:34:15: error: undefined identifier 'bad_atomic'
  * check-error-end
  */
diff --git a/validation/c23-constexpr-error.c b/validation/c23-constexpr-=
error.c
index 41ee86d7ae63..370f2409c99a 100644
--- a/validation/c23-constexpr-error.c
+++ b/validation/c23-constexpr-error.c
@@ -50,7 +50,7 @@ void assign_and_vla_test(int n)
 	constexpr int arr[2] =3D { 1, 2 };
 	arr[0] =3D 3;
=20
-	constexpr int (*vla)[n] =3D nullptr;
+	constexpr int vla[n] =3D {};
 	(void)vla;
 }
=20
diff --git a/validation/c23-empty-init-error.c b/validation/c23-empty-ini=
t-error.c
new file mode 100644
index 000000000000..b5f39174e1e4
--- /dev/null
+++ b/validation/c23-empty-init-error.c
@@ -0,0 +1,19 @@
+static int inc_arr[] =3D {};
+
+struct inc_struct;
+
+static void bad_init(void)
+{
+	struct inc_struct x =3D {};
+	(void)x;
+}
+
+/*
+ * check-name: c23-empty-init-error
+ * check-command: sparse -std=3Dc23 $file
+ *
+ * check-error-start
+c23-empty-init-error.c:1:12: error: empty initializer for incomplete arr=
ay
+c23-empty-init-error.c:7:31: error: initializer for incomplete type
+ * check-error-end
+ */
diff --git a/validation/c23-empty-init-pedantic.c b/validation/c23-empty-=
init-pedantic.c
new file mode 100644
index 000000000000..19dfb769f16b
--- /dev/null
+++ b/validation/c23-empty-init-pedantic.c
@@ -0,0 +1,14 @@
+struct s {
+	int a;
+};
+
+static struct s s =3D {};
+
+/*
+ * check-name: c23 empty initializer pedantic warning
+ * check-command: sparse -std=3Dc11 -Wpedantic $file
+ *
+ * check-error-start
+c23-empty-init-pedantic.c:5:21: warning: ISO C forbids empty initializer=
 braces before C23
+ * check-error-end
+ */
diff --git a/validation/c23-empty-init.c b/validation/c23-empty-init.c
new file mode 100644
index 000000000000..8af4ddf86e42
--- /dev/null
+++ b/validation/c23-empty-init.c
@@ -0,0 +1,64 @@
+struct s {
+	int a;
+	void *ptr;
+};
+
+struct nested {
+	struct s inner;
+	int arr[2];
+};
+
+union u {
+	int a;
+	char *p;
+};
+
+enum e {
+	E0,
+	E1,
+};
+
+typedef typeof(nullptr) nullptr_t;
+
+static int i =3D {};
+static float f =3D {};
+static double d =3D {};
+static void *p =3D {};
+static bool b =3D {};
+static nullptr_t np =3D {};
+static enum e ge =3D {};
+static struct s s =3D {};
+static struct s s2 =3D { {}, {} };
+static struct nested ns =3D { {}, {} };
+static union u u =3D {};
+static int arr[3] =3D {};
+
+static constexpr int ci =3D {};
+static constexpr bool cb =3D {};
+static_assert(ci =3D=3D 0, "ci");
+static_assert(cb =3D=3D false, "cb");
+
+static int test(int n)
+{
+	int local_i =3D {};
+	void *local_p =3D {};
+	struct s local_s =3D {};
+	int local_arr[2] =3D {};
+	int vla[n] =3D {};
+	int cl_i =3D (int){};
+	struct s cl_s =3D (struct s){};
+	int *cl_arr =3D (int [3]){};
+
+	(void)local_p;
+	(void)local_s;
+	(void)cl_s;
+	return local_i + local_arr[0] + vla[0] + cl_i + cl_arr[0] +
+	       i + (int)f + (int)d + (p !=3D nullptr) + b + (np !=3D nullptr) +
+	       ge + s.a + s2.a + (s2.ptr !=3D nullptr) +
+	       ns.inner.a + u.a + arr[0];
+}
+
+/*
+ * check-name: c23 empty initializer braces
+ * check-command: sparse -std=3Dc23 -pedantic -Wno-vla $file
+ */

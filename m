Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256431;
	b=xxoP+gkItX3yfYJqOjU6Xl6OUf8TjJGQG7Nn6nVnEYqevWXSqe3ejbf/gm25vQm492/T
	 b2w0JIGi0qg/K1H9FGtiC0yUZWDWFiWP0uUx5YALYuSFppzSAWpYnL33/aOeOKKtjEmKA
	 XegyaB9/RPIa8jpFJ2Pi5vGCrwHb3kTabqcnE2aqTzDjGTncVyq2eeXvaIB5gsN1cMC4y
	 QulSOyTyzdkWHp3lre8CsHdzYwqLAiSz4x4A9ORyjisWbzNoHpssxuxSk2gDJ1PhQwlQC
	 sRyhAxcx+Q6N10Uh6p4DwYpNF+kkmrmpOmxHWv5X213lCCm/JAPeo89EU6s07/ZpsvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256431;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=HcpXMCH0q9crFSD9xYyTswCdc0pB0wAZWoobPrJvv8U=;
	b=K7Z8zv2wik/5fSjK4jTdXnSCt9x50RY7ItDG9XWJ1DVi87OBhHasSJkNLYJ1OIAPGTDv
	 60PaqvDWIAtphYrVHdCK+ZRL+THtn28whwND4OCq7lX6w3dWv8AG53HJcGZ1lCxFBQHb5
	 ZMHRb8lkuIMolVDqjGb4OZr0ZKGiRjpv7AUDiaVSVqlCduJ1ktiiWK85f3zin97eCXKAM
	 uhb17oNBgEYU6TsmfjpuEa9mDcii/hYKHCjt8ep881YbR9OngTqg8CM32Ao54H8kOegKv
	 pdzx2ByvUv4kRsUWrUraGH6nHdLibdTTyYVySehPNvmBr1d/29t+QPIWwBny7D77ZTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=z4XT8dqT;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CCB606A31C
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9CCB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=z4XT8dqT
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhMD18Rhz1XMFx6;
	Mon,  9 Nov 2026 20:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256416; x=1796848417; bh=HcpXM
	CH0q9crFSD9xYyTswCdc0pB0wAZWoobPrJvv8U=; b=z4XT8dqT78c4LZq3iuqS4
	5BVftKGysaxC3ehlU7nj9N8V69s50MoBA4PsNpKXIXuBWSwKSRDvfjpq0fqdAo8/
	GZdgR8mVIq1qzJ6bcVFaQCTJbUHrvkGOmQYgTmVTd4mwJkxzVNaf2cQH8njHjrfp
	ogNbj/gyVlBf/5C/QVsBlTLBTmQG6izUFy/U6+3GISez5eHy9XQsijj6fR1k0Rqx
	voCHu0gi6506xj4OjTpXUr91MDFeQfINgQt0sJI4QKYQXpHjZziYvczbphqqld0P
	KRNdwq3jvlI79+Vt59J7CcxXrgTEsBu6kY8TjIAjjkT49PLVJbnihTOkzP5El+FX
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id y8wegwvJ3b8T; Mon,  9 Nov 2026 20:33:36 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM25Qxsz1XLwXQ;
	Mon,  9 Nov 2026 20:33:34 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 47/73] c23: Support variadic functions without named parameters
Date: Mon,  9 Nov 2026 12:32:33 -0800
Message-ID: <20261109203259.362845-48-bvanassche@acm.org>
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

Allow variadic function prototypes and definitions of the form 'f(...)'
without a preceding named parameter and support single-argument va_start
in C23 mode per ISO C23 6.7.6.3 and 7.16.1.4:
- Replace the predefined 2-argument __builtin_va_start macro in lib.c
  with builtin handlers for __builtin_va_start and
  __builtin_c23_va_start in builtin.c so <stdarg.h> works with both
  va_start(ap) and va_start(ap, ...).
- Validate that va_start appears inside a variadic function on a
  modifiable va_list lvalue, leave extra C23 va_start arguments
  unevaluated, and lower va_start to initialize ap.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 builtin.c                          | 77 ++++++++++++++++++++++++++++++
 lib.c                              |  1 -
 parse.c                            |  5 +-
 validation/c11-va-start-error.c    | 20 ++++++++
 validation/c23-variadic-error.c    | 41 ++++++++++++++++
 validation/c23-variadic-no-named.c | 47 ++++++++++++++++++
 validation/linear/c23-va-start.c   | 22 +++++++++
 7 files changed, 210 insertions(+), 3 deletions(-)
 create mode 100644 validation/c11-va-start-error.c
 create mode 100644 validation/c23-variadic-error.c
 create mode 100644 validation/c23-variadic-no-named.c
 create mode 100644 validation/linear/c23-va-start.c

diff --git a/builtin.c b/builtin.c
index 78a971ce4bb5..0be03c51aedd 100644
--- a/builtin.c
+++ b/builtin.c
@@ -638,6 +638,81 @@ static struct symbol_op object_size_op =3D {
 	.expand =3D expand_object_size,
 };
=20
+static int args_va_start(struct expression *expr)
+{
+	struct symbol *sym =3D expr->fn->ctype;
+	bool is_c23 =3D !strcmp(show_ident(sym->ident), "__builtin_c23_va_start=
");
+	int n =3D expression_list_size(expr->args);
+	struct expression *arg;
+	int i =3D 0;
+
+	if (n < 1 || (!is_c23 && standard < STANDARD_C23 && n < 2)) {
+		expression_error(expr, "not enough arguments for %s",
+				 show_ident(sym->ident));
+		return 0;
+	}
+	if (!is_c23 && n > 2) {
+		expression_error(expr, "too many arguments for %s",
+				 show_ident(sym->ident));
+		return 0;
+	}
+	FOR_EACH_PTR(expr->args, arg) {
+		if (i =3D=3D 1 && !is_c23) {
+			if (!evaluate_expression(arg))
+				return 0;
+		}
+		i++;
+	} END_FOR_EACH_PTR(arg);
+	return 1;
+}
+
+static int evaluate_va_start(struct expression *expr)
+{
+	struct expression *ap =3D first_expression(expr->args);
+	struct symbol *fntype =3D current_fn ? current_fn->ctype.base_type : NU=
LL;
+	struct expression *assign, *rhs;
+
+	if (current_fn && current_fn->type =3D=3D SYM_FN)
+		fntype =3D current_fn;
+	if (!fntype || !fntype->variadic) {
+		expression_error(expr, "'va_start' used in function with fixed args");
+		return 1;
+	}
+
+	if (!evaluate_expression(ap) || !valid_type(ap->ctype))
+		return 1;
+	{
+		struct symbol *atype =3D ap->ctype;
+		while (atype && atype->type =3D=3D SYM_NODE)
+			atype =3D atype->ctype.base_type;
+		if (atype !=3D &ptr_ctype) {
+			expression_error(expr, "incorrect type in 'va_start'");
+			return 1;
+		}
+	}
+
+	rhs =3D alloc_expression(expr->pos, EXPR_VALUE);
+	rhs->ctype =3D &ptr_ctype;
+	rhs->value =3D 0;
+
+	assign =3D alloc_expression(expr->pos, EXPR_ASSIGNMENT);
+	assign->op =3D '=3D';
+	assign->left =3D ap;
+	assign->right =3D rhs;
+	evaluate_expression(assign);
+
+	expr->type =3D EXPR_CAST;
+	expr->cast_type =3D &void_ctype;
+	expr->cast_expression =3D assign;
+	expr->ctype =3D &void_ctype;
+	return 1;
+}
+
+static struct symbol_op va_start_op =3D {
+	.args =3D args_va_start,
+	.evaluate =3D evaluate_va_start,
+};
+
 static int evaluate_strlen(struct expression *expr)
 {
 	struct expression *arg =3D first_expression(expr->args);
@@ -876,7 +951,9 @@ static const struct builtin_fn builtins_common[] =3D =
{
 	{ "__builtin_usub_overflow", &bool_ctype, 0, { &uint_ctype, &uint_ctype=
, &uint_ptr_ctype }},
 	{ "__builtin_usubl_overflow", &bool_ctype, 0, { &ulong_ctype, &ulong_ct=
ype, &ulong_ptr_ctype }},
 	{ "__builtin_usubll_overflow", &bool_ctype, 0, { &ullong_ctype, &ullong=
_ctype, &ullong_ptr_ctype }},
+	{ "__builtin_c23_va_start", &void_ctype, 1, .op =3D &va_start_op },
 	{ "__builtin_va_arg_pack_len", size_t_ctype, 0 },
+	{ "__builtin_va_start", &void_ctype, 1, .op =3D &va_start_op },
 	{ "__builtin_vprintf", &int_ctype, 0, { &const_string_ctype, va_list_ct=
ype }},
 	{ "__builtin_vsnprintf", &int_ctype, 0, { &string_ctype, size_t_ctype, =
&const_string_ctype, va_list_ctype }},
 	{ "__builtin_vsprintf", &int_ctype, 0, { &string_ctype, &const_string_c=
type, va_list_ctype }},
diff --git a/lib.c b/lib.c
index 6670e3b46657..3c41c41855c4 100644
--- a/lib.c
+++ b/lib.c
@@ -299,7 +299,6 @@ static void create_builtin_stream(void)
 	add_pre_buffer("#add_system \"%s/include-fixed\"\n", gcc_base_dir);
=20
 	add_pre_buffer("#define __builtin_stdarg_start(a,b) ((a) =3D (__builtin=
_va_list)(&(b)))\n");
-	add_pre_buffer("#define __builtin_va_start(a,b) ((a) =3D (__builtin_va_=
list)(&(b)))\n");
 	add_pre_buffer("#define __builtin_ms_va_start(a,b) ((a) =3D (__builtin_=
ms_va_list)(&(b)))\n");
 	add_pre_buffer("#define __builtin_va_arg(arg,type)  ({ type __va_arg_re=
t =3D *(type *)(arg); arg +=3D sizeof(type); __va_arg_ret; })\n");
 	add_pre_buffer("#define __builtin_va_alist (*(void *)0)\n");
diff --git a/parse.c b/parse.c
index 6af5bfba2392..78ad5f09e2ad 100644
--- a/parse.c
+++ b/parse.c
@@ -1926,8 +1926,9 @@ static enum kind which_func(struct token *token,
 	}
=20
 	if (next->special =3D=3D SPECIAL_ELLIPSIS) {
-		warning(next->pos,
-			"variadic functions must have one named argument");
+		if (standard < STANDARD_C23)
+			warning(next->pos,
+				"variadic functions must have one named argument");
 		return Proto;
 	}
=20
diff --git a/validation/c11-va-start-error.c b/validation/c11-va-start-er=
ror.c
new file mode 100644
index 000000000000..334ad0cd48ad
--- /dev/null
+++ b/validation/c11-va-start-error.c
@@ -0,0 +1,20 @@
+#include <stdarg.h>
+
+static void f(int n, ...)
+{
+	va_list ap;
+	(void)n;
+	va_start(ap);
+	__builtin_va_start(ap);
+}
+
+/*
+ * check-name: c11-va-start-error
+ * check-command: sparse -std=3Dc11 $file
+ *
+ * check-error-start
+c11-va-start-error.c:7:9: error: macro "va_start" requires 2 arguments, =
but only 1 given
+c11-va-start-error.c:7:9: error: undefined identifier 'va_start'
+c11-va-start-error.c:8:27: error: not enough arguments for __builtin_va_=
start
+ * check-error-end
+ */
diff --git a/validation/c23-variadic-error.c b/validation/c23-variadic-er=
ror.c
new file mode 100644
index 000000000000..85032625fff3
--- /dev/null
+++ b/validation/c23-variadic-error.c
@@ -0,0 +1,41 @@
+#include <stdarg.h>
+
+static const va_list const_ap;
+
+static void fixed_fn(int x)
+{
+	va_list ap;
+	(void)x;
+	va_start(ap);
+}
+
+static void variadic_errors(...)
+{
+	int not_ap =3D 0;
+	void *void_ptr =3D nullptr;
+	va_list ap;
+
+	__builtin_va_start();
+	__builtin_va_start(ap, 1, 2);
+	va_start(not_ap);
+	va_start(void_ptr);
+	va_start(const_ap);
+	(void)(va_start(ap) + 1);
+}
+
+/*
+ * check-name: c23-variadic-error
+ * check-command: sparse -std=3Dc23 $file
+ *
+ * check-error-start
+c23-variadic-error.c:9:9: error: 'va_start' used in function with fixed =
args
+c23-variadic-error.c:18:27: error: not enough arguments for __builtin_va=
_start
+c23-variadic-error.c:19:27: error: too many arguments for __builtin_va_s=
tart
+c23-variadic-error.c:20:9: error: incorrect type in 'va_start'
+c23-variadic-error.c:21:9: error: incorrect type in 'va_start'
+c23-variadic-error.c:22:9: error: assignment to const expression
+c23-variadic-error.c:23:29: error: incompatible types for operation (+):
+c23-variadic-error.c:23:29:    void
+c23-variadic-error.c:23:29:    int
+ * check-error-end
+ */
diff --git a/validation/c23-variadic-no-named.c b/validation/c23-variadic=
-no-named.c
new file mode 100644
index 000000000000..35e38f7ae177
--- /dev/null
+++ b/validation/c23-variadic-no-named.c
@@ -0,0 +1,47 @@
+#include <stdarg.h>
+
+static void v1(...)
+{
+}
+
+static int sum_two(...)
+{
+	va_list ap, copy;
+	int a, b;
+
+	va_start(ap);
+	va_copy(copy, ap);
+	a =3D va_arg(ap, int);
+	b =3D va_arg(ap, int);
+	va_end(copy);
+	va_end(ap);
+	return a + b;
+}
+
+static int sum_after_n(int n, ...)
+{
+	va_list ap;
+	int a;
+
+	va_start(ap, n);
+	va_end(ap);
+	va_start(ap, undeclared_ignored_token, 1, 2);
+	a =3D va_arg(ap, int);
+	va_end(ap);
+	return n + a;
+}
+
+static int test(void)
+{
+	int (*fp)(...) =3D sum_two;
+
+	v1();
+	v1(1);
+	v1(1, 2, "three");
+	return fp(10, 20) + sum_after_n(5, 7);
+}
+
+/*
+ * check-name: c23-variadic-no-named
+ * check-command: sparse -std=3Dc23 -pedantic $file
+ */
diff --git a/validation/linear/c23-va-start.c b/validation/linear/c23-va-=
start.c
new file mode 100644
index 000000000000..2d5b11d58aa4
--- /dev/null
+++ b/validation/linear/c23-va-start.c
@@ -0,0 +1,22 @@
+#include <stdarg.h>
+
+int first_arg(...);
+int first_arg(...)
+{
+	va_list ap;
+	int v;
+
+	va_start(ap);
+	v =3D va_arg(ap, int);
+	va_end(ap);
+	return v;
+}
+
+/*
+ * check-name: linear-c23-va-start
+ * check-command: test-linearize -m64 -std=3Dc23 -Wuninitialized $file
+ *
+ * check-output-ignore
+ * check-output-excludes: __builtin_va_start
+ * check-output-excludes: __builtin_c23_va_start
+ */

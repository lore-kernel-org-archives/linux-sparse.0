Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256423;
	b=d9nm2sNycxWa7Woy0fDhFlt7nL4gJPlzMxOadiv4SFLdNpX2YAK15xnt7gWwM1e4MTmD
	 KeNkp1LYrglbV7e67iIWCQqjQY9Gh5dFX8iLQwt/BDSVoZEH3Aw8tfuI83jzPrHqG6kkO
	 MBHulpYDwVWe/CfvARCj0zJ9i5Aysoa7YauFs50X5Q2aDYotYXU1yZY1s3BsA3ESp12tW
	 JFXorgckz+EJzkNIcjNuyjDld93b7t+iMOS7sFRQpCMCoWMjSFnAqm3irDZwoYpehzW0B
	 s9G3hTfjpH6h7pssY0cQhQf+QY+1+p40zpBxYp1jBvOUWZpK473084mbZh8zbgzX4+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256423;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=VUvzTAXGnscL2K+p6fJYUQAUkuOTxPsT7t2RsaM7rAc=;
	b=TMyir+k1K1s1vu04XJHNXu3ejEl4DALX4CteCKb3+93wrL0b2+T6u0UI0oIJr+/FyWcO
	 cc2fDSXhFACNXYgWjy0MfLnXxf+5hCbf6G/siko20J+Vw1OdvmLDt4sLd7hffVY5sb+Ua
	 p17oxzqXPxClLWtnv/aFB20PJYgP5LcihllNX+MESBBCgcFcFxRYvPWlnas5Oor4VAUbL
	 LePwHu5P6NsKuiaP3CZz2qwIWp73H4vHDF/4k6NiR6kI8F2DzHDQAfTMBw+ZC+VX9qfCa
	 7XJ8likXuja+J4er93oYKQzMYgOS9kIxt6iL66gjJztITY+mSZCaPIrUDwdtllZN2jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=0DuWuHBY;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B65606A31C
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86B65606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=0DuWuHBY
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhM620BVz1XLyNK;
	Mon,  9 Nov 2026 20:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256414; x=1796848415; bh=VUvzT
	AXGnscL2K+p6fJYUQAUkuOTxPsT7t2RsaM7rAc=; b=0DuWuHBYhNhXnFjoRbE1J
	5wtb1smA1s2Iygxx+3vbG9bZuRrqpmjSdW+MMEmFfjsyUkJjasGxyTCPa7CH1PJ7
	rWeEor2BSbPnA4zraqgJLd+4ZbDgjA+htCmXJhNjwyZXIALHwQGOgFaltMlTZZNa
	e+3gWPfrAhabhq7I80Si7Zbrx7q67CqbjAgxWpTmhij8T4vapYbLz0oksf4yOirc
	ktkfiTrMhUhKo4NXvG5lM1m5UcaibTn213H2Zb52xMHUO9g0rvxLNDJevu5k4D7C
	X8ndWHMFRGS+zD7OL7crIPBysga59A74M0QWjiKxbE/0uur11945eMevIFprvQXx
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id oby5J_CIdK1l; Mon,  9 Nov 2026 20:33:34 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLw6nrcz1XMG4K;
	Mon,  9 Nov 2026 20:33:28 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 21/73] compile-i386: Fix buffer bounds, unsigned '<=' codegen, and null checks
Date: Mon,  9 Nov 2026 12:32:07 -0800
Message-ID: <20261109203259.362845-22-bvanassche@acm.org>
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

Harden x86 code generation in compile-i386.c:
- Enlarge fixed formatting buffers and replace strcpy()/sprintf() calls
  with bounded snprintf() in stor_op_name(), emit_insn_atom(), and
  emit_global_noinit().
- Guard against zero-length array division by zero in emit_initializer()
  and use sym->bit_size / 8 directly in emit_array_noinit().
- Emit 'setbe' instead of 'setb' for SPECIAL_UNSIGNED_LTE in
  emit_compare().
- Handle SYM_PTR scalar initializers and guard current_func and
  stmt->goto_label before dereferencing them.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 compile-i386.c | 76 ++++++++++++++++++++++++++++----------------------
 1 file changed, 43 insertions(+), 33 deletions(-)

diff --git a/compile-i386.c b/compile-i386.c
index 16b3893a4ef1..81f6a9a7eceb 100644
--- a/compile-i386.c
+++ b/compile-i386.c
@@ -434,30 +434,30 @@ static void stor_sym_init(struct symbol *sym)
=20
 static const char *stor_op_name(struct storage *s)
 {
-	static char name[32];
+	static char name[256];
=20
 	switch (s->type) {
 	case STOR_PSEUDO:
-		strcpy(name, pretty_offset((int) pseudo_offset(s)));
+		snprintf(name, sizeof(name), "%s", pretty_offset((int) pseudo_offset(s=
)));
 		break;
 	case STOR_ARG:
-		strcpy(name, pretty_offset((int) arg_offset(s)));
+		snprintf(name, sizeof(name), "%s", pretty_offset((int) arg_offset(s)))=
;
 		break;
 	case STOR_SYM:
-		strcpy(name, show_ident(s->sym->ident));
+		snprintf(name, sizeof(name), "%s", show_ident(s->sym->ident));
 		break;
 	case STOR_REG:
-		strcpy(name, s->reg->name);
+		snprintf(name, sizeof(name), "%s", s->reg->name);
 		break;
 	case STOR_VALUE:
-		sprintf(name, "$%lld", s->value);
+		snprintf(name, sizeof(name), "$%lld", s->value);
 		break;
 	case STOR_LABEL:
-		sprintf(name, "%s.L%d", s->flags & STOR_LABEL_VAL ? "$" : "",
+		snprintf(name, sizeof(name), "%s.L%d", s->flags & STOR_LABEL_VAL ? "$"=
 : "",
 			s->label);
 		break;
 	case STOR_LABELSYM:
-		sprintf(name, "%s.LS%p", s->flags & STOR_LABEL_VAL ? "$" : "",
+		snprintf(name, sizeof(name), "%s.LS%p", s->flags & STOR_LABEL_VAL ? "$=
" : "",
 			s->labelsym);
 		break;
 	}
@@ -707,27 +707,27 @@ static void emit_section(const char *s)
=20
 static void emit_insn_atom(struct function *f, struct atom *atom)
 {
-	char s[128];
-	char comment[64];
+	char s[512];
+	char comment[128];
 	struct storage *op1 =3D atom->op1;
 	struct storage *op2 =3D atom->op2;
=20
 	if (atom->comment[0])
-		sprintf(comment, "\t\t# %s", atom->comment);
+		snprintf(comment, sizeof(comment), "\t\t# %s", atom->comment);
 	else
 		comment[0] =3D 0;
=20
 	if (atom->op2) {
-		char tmp[16];
-		strcpy(tmp, stor_op_name(op1));
-		sprintf(s, "\t%s\t%s, %s%s\n",
+		char tmp[256];
+		snprintf(tmp, sizeof(tmp), "%s", stor_op_name(op1));
+		snprintf(s, sizeof(s), "\t%s\t%s, %s%s\n",
 			atom->insn, tmp, stor_op_name(op2), comment);
 	} else if (atom->op1)
-		sprintf(s, "\t%s\t%s%s%s\n",
+		snprintf(s, sizeof(s), "\t%s\t%s%s%s\n",
 			atom->insn, stor_op_name(op1),
 			comment[0] ? "\t" : "", comment);
 	else
-		sprintf(s, "\t%s\t%s%s\n",
+		snprintf(s, sizeof(s), "\t%s\t%s%s\n",
 			atom->insn,
 			comment[0] ? "\t\t" : "", comment);
=20
@@ -941,16 +941,16 @@ static void emit_scalar(struct expression *expr, un=
signed int bit_size)
 static void emit_global_noinit(const char *name, unsigned long modifiers=
,
 			       unsigned long alignment, unsigned int byte_size)
 {
-	char s[64];
+	char s[256];
=20
 	if (modifiers & MOD_STATIC) {
-		sprintf(s, "\t.local\t%s\n", name);
+		snprintf(s, sizeof(s), "\t.local\t%s\n", name);
 		textbuf_push(&unit_post_text, s);
 	}
 	if (alignment)
-		sprintf(s, "\t.comm\t%s,%d,%lu\n", name, byte_size, alignment);
+		snprintf(s, sizeof(s), "\t.comm\t%s,%d,%lu\n", name, byte_size, alignm=
ent);
 	else
-		sprintf(s, "\t.comm\t%s,%d\n", name, byte_size);
+		snprintf(s, sizeof(s), "\t.comm\t%s,%d\n", name, byte_size);
 	textbuf_push(&unit_post_text, s);
 }
=20
@@ -966,9 +966,14 @@ static void emit_initializer(struct symbol *sym,
=20
 	if (expr->type =3D=3D EXPR_VALUE) {
 		struct symbol *base_type =3D sym->ctype.base_type;
+		long long nr;
 		assert(base_type !=3D NULL);
=20
-		emit_scalar(expr, sym->bit_size / get_expression_value(base_type->arra=
y_size));
+		nr =3D get_expression_value(base_type->array_size);
+		if (nr > 0)
+			emit_scalar(expr, sym->bit_size / nr);
+		else if (base_type->ctype.base_type && base_type->ctype.base_type->bit=
_size > 0)
+			emit_scalar(expr, base_type->ctype.base_type->bit_size);
 		return;
 	}
 	if (expr->type !=3D EXPR_INITIALIZER)
@@ -1129,7 +1134,7 @@ static void emit_array_noinit(struct symbol *sym)
 {
 	emit_global_noinit(show_ident(sym->ident),
 			   sym->ctype.modifiers, sym->ctype.alignment,
-			   get_expression_value(sym->array_size) * (sym->bit_size / 8));
+			   sym->bit_size / 8);
 	stor_sym_init(sym);
 }
=20
@@ -1249,7 +1254,7 @@ static struct storage *emit_compare(struct expressi=
on *expr)
 	case SPECIAL_UNSIGNED_GT:
 				opname =3D "seta";	break;
 	case SPECIAL_UNSIGNED_LTE:
-				opname =3D "setb";	break;
+				opname =3D "setbe";	break;
 	case SPECIAL_UNSIGNED_GTE:
 				opname =3D "setae";	break;
 	default:
@@ -1820,13 +1825,16 @@ static void x86_symbol(struct symbol *sym)
 		break;
=20
 	case SYM_BASETYPE:
+	case SYM_PTR:
 		if (sym->initializer) {
-			emit_object_pre(show_ident(sym->ident),
-					sym->ctype.modifiers,
-				        sym->ctype.alignment,
-					sym->bit_size / 8);
-			emit_scalar(sym->initializer, sym->bit_size);
-			stor_sym_init(sym);
+			if (sym->initializer->type =3D=3D EXPR_VALUE) {
+				emit_object_pre(show_ident(sym->ident),
+						sym->ctype.modifiers,
+					        sym->ctype.alignment,
+						sym->bit_size / 8);
+				emit_scalar(sym->initializer, sym->bit_size);
+				stor_sym_init(sym);
+			}
 		} else
 			emit_scalar_noinit(sym);
 		break;
@@ -1857,8 +1865,8 @@ static void x86_symbol(struct symbol *sym)
 		break;
 	}
=20
-	if (sym->initializer && (type->type !=3D SYM_BASETYPE) &&
-	    (type->type !=3D SYM_ARRAY)) {
+	if (current_func && sym->initializer && (type->type !=3D SYM_BASETYPE) =
&&
+	    (type->type !=3D SYM_ARRAY) && (type->type !=3D SYM_PTR)) {
 		printf(" =3D \n");
 		x86_expression(sym->initializer);
 	}
@@ -2039,12 +2047,14 @@ static struct storage *x86_statement(struct state=
ment *stmt)
 		if (stmt->goto_expression) {
 			struct storage *val =3D x86_expression(stmt->goto_expression);
 			printf("\tgoto *v%d\n", val->pseudo);
-		} else if (!strcmp("break", show_ident(stmt->goto_label->ident))) {
+		} else if (stmt->goto_label && stmt->goto_label->ident &&
+			   !strcmp("break", show_ident(stmt->goto_label->ident))) {
 			struct storage *lbv =3D new_storage(STOR_LABEL);
 			lbv->label =3D loopstk_break();
 			lbv->flags =3D STOR_WANTS_FREE;
 			insn("jmp", lbv, NULL, "'break'; go to loop bottom");
-		} else if (!strcmp("continue", show_ident(stmt->goto_label->ident))) {
+		} else if (stmt->goto_label && stmt->goto_label->ident &&
+			   !strcmp("continue", show_ident(stmt->goto_label->ident))) {
 			struct storage *lbv =3D new_storage(STOR_LABEL);
 			lbv->label =3D loopstk_continue();
 			lbv->flags =3D STOR_WANTS_FREE;

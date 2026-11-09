Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256416;
	b=2FTR72I5LnCLzCpVDE13kWnBGKu1QiDIcOyP7v1ZBpG4gQ+GA+dl50ISDnYFpY6l4eYV
	 2Vu83ZurpZa6Ud7eWjsm37Dm7JZ4NUD1KjksYKR9/TVX1ptcsr36iJqMQMO6ZXQKdKofr
	 sUliilVfFApjYlmiROcJ4QPSi0u3ysRCF+juFLy6fgEZksvxLQu7RQOgbFWc1CxOAgiDL
	 aoEDoV1aSNK/2Z0bta8sMQl7jk5+mXdHynJMfLrlP1n8FNevmLRGaQSM+wZOYw0EOskFK
	 S0nOM30B859VWwCls1CDUjDqgFX1NXHLFLlFHFSnT76CbZLvL4GNWb5uX7WyveO6DFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=gj5rbCmXFN87pDjrvsIaDMjHqyQ0RJPGgO1j3Jq5PWk=;
	b=LqYOwXsTl/zMp8Be9PT+fyhaP+68hgQL5zrQZf+hbnGI8hyKIBshNkcNL77xxPCM2+LM
	 SyUJZ0km/eLWoveAxbsAfT9vMvZ2/tcGG/W8oL3e/NotJ8wdL4+qKNDU+qMn7a8jx+Q+E
	 N5o4PJc5OG4yV9SCKJ1+3sSx+dvOXyMwW6ScVnLHKar6/XFQ6ux69lB5wke6R4adnnYr1
	 KePmlQDzApS/VFMJNBtg/Dq2rn/MX/W7E5G0VUNIF/9sNHZBHoWo/wglRklP9TClfqHR9
	 8hBloTRmY3oQ01lF+o9Cb8gjIoEmyHLcBEAqp8AF1mLllqI/2bemA68cl1XPsGgnWVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b="w7xTs/PZ";
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3358606A326
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3358606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=w7xTs/PZ
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhM24bpjz1XMYJk;
	Mon,  9 Nov 2026 20:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256411; x=1796848412; bh=gj5rb
	CmXFN87pDjrvsIaDMjHqyQ0RJPGgO1j3Jq5PWk=; b=w7xTs/PZJuhguiPzdxDk1
	dnRWThLWuFNlAvnTxBqBG+S7ewooLqCnAJHRLV8VdUp5R3vBYX90DfynZH3a+/Kk
	DDM9UHytpse1NnCGs5Iz/8sX6gT7SNkKIr0Ud0FROfjFCLjeUMQ6FdKHt9kOkxDI
	2XPtc4yaPGijSp9pk7hMsFoQlwzN38RlT+ebfUKd52Xxyrzxd76dsbVDsWIEcuAc
	Sbd5Gv6ta0IQTL6H1ke0i/xBw3tWdc1w6lU+GyUWLWkeesh0mYXHFRR8hCIWoHpK
	N22KrE78p85tuYXnWU+ajx5Buzgjn3CZbQz1KAYUNHKCZwL8SKE84GkO3ccB2SQl
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id JuQAsdp4T2Ds; Mon,  9 Nov 2026 20:33:31 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLv4QYBz1XLwXQ;
	Mon,  9 Nov 2026 20:33:27 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 15/73] linearize, flow: Fix asm operands, switch case bounds, and DSE
Date: Mon,  9 Nov 2026 12:32:01 -0800
Message-ID: <20261109203259.362845-16-bvanassche@acm.org>
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

Fix IR linearization and dead-store elimination issues in flow.c and
linearize.c:
- Continue scanning past OP_CALL for non-escaping locals while stopping
  at OP_ASM in kill_dead_stores_bb().
- Enlarge show_pseudo() formatting buffers and replace sprintf() with
  bounded snprintf().
- Guard VOID phi sources in linearize_logical(), register read-write
  '+r' asm outputs as inputs, guard non-string asm clobbers, and extend
  switch case values to the controlling expression width.
- Add regression test validation/linear/control-flow-fixes.c.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 flow.c                                 |  3 ++
 linearize.c                            | 46 ++++++++++++++++----------
 validation/linear/control-flow-fixes.c | 44 ++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 18 deletions(-)
 create mode 100644 validation/linear/control-flow-fixes.c

diff --git a/flow.c b/flow.c
index 48755501e464..f89cd755a1ae 100644
--- a/flow.c
+++ b/flow.c
@@ -518,6 +518,9 @@ static void kill_dead_stores_bb(pseudo_t pseudo, unsi=
gned long generation, struc
 		case OP_CALL:
 			if (!local)
 				return;
+			continue;
+		case OP_ASM:
+			return;
 		default:
 			continue;
 		}
diff --git a/linearize.c b/linearize.c
index 75850df0a90f..c6ec3703b149 100644
--- a/linearize.c
+++ b/linearize.c
@@ -98,7 +98,7 @@ const char *show_label(struct basic_block *bb)
 const char *show_pseudo(pseudo_t pseudo)
 {
 	static int n;
-	static char buffer[4][64];
+	static char buffer[4][256];
 	char *buf;
 	int i;
=20
@@ -113,23 +113,23 @@ const char *show_pseudo(pseudo_t pseudo)
 		struct expression *expr;
=20
 		if (!sym) {
-			snprintf(buf, 64, "<bad symbol>");
+			snprintf(buf, sizeof(buffer[0]), "<bad symbol>");
 			break;
 		}
 		if (sym->bb_target) {
-			snprintf(buf, 64, "%s", show_label(sym->bb_target));
+			snprintf(buf, sizeof(buffer[0]), "%s", show_label(sym->bb_target));
 			break;
 		}
 		if (sym->ident) {
-			snprintf(buf, 64, "%s", show_ident(sym->ident));
+			snprintf(buf, sizeof(buffer[0]), "%s", show_ident(sym->ident));
 			break;
 		}
 		expr =3D sym->initializer;
-		snprintf(buf, 64, "<anon symbol:%p>", verbose ? sym : NULL);
+		snprintf(buf, sizeof(buffer[0]), "<anon symbol:%p>", verbose ? sym : N=
ULL);
 		if (expr) {
 			switch (expr->type) {
 			case EXPR_VALUE:
-				snprintf(buf, 64, "<symbol value: %lld>", expr->value);
+				snprintf(buf, sizeof(buffer[0]), "<symbol value: %lld>", expr->value=
);
 				break;
 			case EXPR_STRING:
 				return show_string(expr->string);
@@ -140,30 +140,30 @@ const char *show_pseudo(pseudo_t pseudo)
 		break;
 	}
 	case PSEUDO_REG:
-		i =3D snprintf(buf, 64, "%%r%d", pseudo->nr);
-		if (pseudo->ident)
-			sprintf(buf+i, "(%s)", show_ident(pseudo->ident));
+		i =3D snprintf(buf, sizeof(buffer[0]), "%%r%d", pseudo->nr);
+		if (pseudo->ident && i < (int)sizeof(buffer[0]))
+			snprintf(buf+i, sizeof(buffer[0]) - i, "(%s)", show_ident(pseudo->ide=
nt));
 		break;
 	case PSEUDO_VAL: {
 		long long value =3D pseudo->value;
 		if (value > 1000 || value < -1000)
-			snprintf(buf, 64, "$%#llx", value);
+			snprintf(buf, sizeof(buffer[0]), "$%#llx", value);
 		else
-			snprintf(buf, 64, "$%lld", value);
+			snprintf(buf, sizeof(buffer[0]), "$%lld", value);
 		break;
 	}
 	case PSEUDO_ARG:
-		snprintf(buf, 64, "%%arg%d", pseudo->nr);
+		snprintf(buf, sizeof(buffer[0]), "%%arg%d", pseudo->nr);
 		break;
 	case PSEUDO_PHI:
-		i =3D snprintf(buf, 64, "%%phi%d", pseudo->nr);
-		if (pseudo->ident)
-			sprintf(buf+i, "(%s)", show_ident(pseudo->ident));
+		i =3D snprintf(buf, sizeof(buffer[0]), "%%phi%d", pseudo->nr);
+		if (pseudo->ident && i < (int)sizeof(buffer[0]))
+			snprintf(buf+i, sizeof(buffer[0]) - i, "(%s)", show_ident(pseudo->ide=
nt));
 		break;
 	case PSEUDO_UNDEF:
 		return "UNDEF";
 	default:
-		snprintf(buf, 64, "<bad pseudo type %d>", pseudo->type);
+		snprintf(buf, sizeof(buffer[0]), "<bad pseudo type %d>", pseudo->type)=
;
 	}
 	return buf;
 }
@@ -1746,7 +1746,8 @@ static pseudo_t linearize_logical(struct entrypoint=
 *ep, struct expression *expr
 	src2 =3D linearize_expression_to_bool(ep, expr->right);
 	src2 =3D cast_pseudo(ep, src2, &bool_ctype, ctype);
 	phi2 =3D alloc_phi(ep->active, src2, ctype);
-	link_phi(node, phi2);
+	if (phi2 !=3D VOID)
+		link_phi(node, phi2);
=20
 	// join
 	set_activeblock(ep, merge);
@@ -2154,6 +2155,8 @@ static pseudo_t linearize_asm_statement(struct entr=
ypoint *ep, struct statement
=20
 	/* ... and the addresses for memory outputs */
 	FOR_EACH_PTR(stmt->asm_outputs, op) {
+		if (op->is_modify && !op->is_memory)
+			add_asm_input(ep, insn, op);
 		add_asm_output_address(ep, insn, op);
 	} END_FOR_EACH_PTR(op);
=20
@@ -2166,7 +2169,8 @@ static pseudo_t linearize_asm_statement(struct entr=
ypoint *ep, struct statement
=20
 	/* and finally, look if it clobbers memory */
 	FOR_EACH_PTR(stmt->asm_clobbers, clob) {
-		if (!strcmp(clob->string->data, "memory"))
+		if (clob->type =3D=3D EXPR_STRING && clob->string &&
+		    !strcmp(clob->string->data, "memory"))
 			insn->clobber_memory =3D 1;
 	} END_FOR_EACH_PTR(clob);
=20
@@ -2262,11 +2266,17 @@ static pseudo_t linearize_switch(struct entrypoin=
t *ep, struct statement *stmt)
 			continue;
 		} else {
 			struct expression *case_to =3D case_stmt->case_to;
+			struct symbol *ctype =3D expr->ctype;
 			long long begin, end;
=20
 			begin =3D end =3D case_stmt->case_expression->value;
 			if (case_to && case_to->type =3D=3D EXPR_VALUE)
 				end =3D case_to->value;
+			if (ctype->bit_size > 0) {
+				bool is_signed =3D !(ctype->ctype.modifiers & MOD_UNSIGNED);
+				begin =3D bits_extend(begin, ctype->bit_size, is_signed);
+				end =3D bits_extend(end, ctype->bit_size, is_signed);
+			}
 			if (begin > end)
 				jmp =3D alloc_multijmp(bb_case, end, begin);
 			else
diff --git a/validation/linear/control-flow-fixes.c b/validation/linear/c=
ontrol-flow-fixes.c
new file mode 100644
index 000000000000..507598d42458
--- /dev/null
+++ b/validation/linear/control-flow-fixes.c
@@ -0,0 +1,44 @@
+/* 1. Statement expression with return inside if condition */
+int stmt_expr_cond(void)
+{
+	if (({ if (0) return 0; 1; }))
+		return 1;
+	return 0;
+}
+
+/* 2. Logical expression with unreachable RHS after return */
+int logical_after_return(int x)
+{
+	return x && ({ return 2; 1; });
+}
+
+/* 3. asm "+r" read-write register and "m" memory operand preserve store=
s */
+int asm_rw_and_mem(void)
+{
+	int x =3D 42;
+	int y =3D 99;
+	asm("" : "+r"(x) : "m"(y));
+	return x;
+}
+
+/* 4. Switch on signed char with negative case label */
+int switch_signed_char(signed char c)
+{
+	switch (c) {
+	case -1:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+/*
+ * check-name: control-flow-fixes
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-excludes: VOID
+ * check-output-contains: store\\.32.*\\$99 -> 0\\[y\\]
+ * check-output-contains: in:.*"+r" (\\$42)
+ * check-output-contains: switch\\.8.*-1 ->
+ */

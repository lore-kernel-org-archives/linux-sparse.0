Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256426;
	b=sbvsKjJJoncGNaAuSyWgkhgjIMujhwTnDAEWURz3OvbECY8AHcaMDEcVG65p1YoqX6uT
	 4pNbNAAsAohcqTMCOzLtKWVrxZful9+34j7eGZB/VqYK+vjQa6XA1QAZM7iXLzRz9EXTf
	 V+HW1S35IyO3+2KAJe+1XwCgp0yZAa5MjT87h8VStH+R8StuUx+kpEL3qBeqp4yz6VaSv
	 UFqd5cd2ZkXFSUOoF23MA8TQnZJixcKs0gOPdCP8F7m5PJVKgWH33vFJTw1DcCj0W9Cqz
	 /KPPk8w0oOYBAgg/MdyzH8R3xFPppTfXq7nkF0CQzT1ssJkiuPRMSVhgrYymVTbMGMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256426;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=QszoqJfTKwR5Wl6oit7kxarS47duqYkEd6WCc8O69Ro=;
	b=cxaSZRVSuyxsGCFJz0QWErYB9Ha/SvyTmDeiFwc/1UcksGJuytArjtmQtTcMxQsFZJr7
	 ZxjlyBIenDDhsU8LvJ34Hi5ssK25fc81U6jOjdeydaFrk0mfQfo0euDMdGsFrAO2qQr5b
	 bQ0g3JhFlC10dIIrFzFUjP13UkcmduLl2NmaEoyfa2PSM64E60bucBl80iPgTENkwHri0
	 EHRR6TNFEounyuDgKGGKb8Iu3YQhfWIp9ZMGoxwedmANmcByBHHW/iWYgv46B9j7X62Mf
	 MTs+MM8luB2krOGdvat/3TOffI1rS3Nv4C3MVPc6SNVJvdEAbbMzLkr7YKKJNevYfKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=MGijJWet;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D434E606A333
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D434E606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=MGijJWet
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhM86jbDz1XM0nk;
	Mon,  9 Nov 2026 20:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256416; x=1796848417; bh=Qszoq
	JfTKwR5Wl6oit7kxarS47duqYkEd6WCc8O69Ro=; b=MGijJWetr6OxlXGQK7jqA
	hPI4040wkdTS6KesiHUrlt7/w88k+VThbw+euT8BnBgGZQm2Mew/Ht5xNJkAU1Ie
	rSCCzsQSrfpMZS2iM5aNRR77OkMJaQc7wBAe0r2pzycAyKHd0OrsLeAcx2MEcDpa
	x+ca8AnhjUWp/lRkXzhL+eO+NxCVpxu20BpwU30pXkZn0JFigrjdPV9QmjNyeLzt
	UQ+F7/f2IjWIYdEVE2U+vVlAS9sZoaeQh8ahcigjji+Bsf2Eqm0O/fHjEMk4Uv+T
	7OPWVB5zCI3w2JLtoZ5vGD6V94kTIVvX16fiQ3QgGVL7Xdu6Z896oiYF9+/TuzGf
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id PBCPT0MICSLi; Mon,  9 Nov 2026 20:33:36 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM16Gz7z1XMYJd;
	Mon,  9 Nov 2026 20:33:33 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 43/73] c23: Add support for bool, true, and false keywords
Date: Mon,  9 Nov 2026 12:32:29 -0800
Message-ID: <20261109203259.362845-44-bvanassche@acm.org>
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

Register bool, true, and false as reserved keywords in C23 mode and
evaluate true and false as integer constant expressions of type bool
with values 1 and 0 in both C expressions and #if conditionals per ISO
C23 6.4.4.5 and 6.10.1.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 expression.c                | 15 ++++++++++++-
 ident-list.h                |  3 +++
 parse.c                     |  3 +++
 pre-process.c               | 10 +++++++++
 validation/c23-bool-error.c | 23 +++++++++++++++++++
 validation/c23-bool.c       | 45 +++++++++++++++++++++++++++++++++++++
 6 files changed, 98 insertions(+), 1 deletion(-)
 create mode 100644 validation/c23-bool-error.c
 create mode 100644 validation/c23-bool.c

diff --git a/expression.c b/expression.c
index 4545adcf4c02..9b07963c914a 100644
--- a/expression.c
+++ b/expression.c
@@ -466,9 +466,22 @@ struct token *primary_expression(struct token *token=
, struct expression **tree)
 	}
=20
 	case TOKEN_IDENT: {
-		struct symbol *sym =3D lookup_symbol(token->ident, NS_SYMBOL | NS_TYPE=
DEF);
+		struct symbol *sym;
 		struct token *next =3D token->next;
=20
+		if (standard >=3D STANDARD_C23 &&
+		    (token->ident =3D=3D &true_ident ||
+		     token->ident =3D=3D &false_ident)) {
+			expr =3D alloc_expression(token->pos, EXPR_VALUE);
+			expr->flags =3D CEF_SET_INT;
+			expr->ctype =3D &bool_ctype;
+			expr->value =3D (token->ident =3D=3D &true_ident);
+			token =3D next;
+			break;
+		}
+
+		sym =3D lookup_symbol(token->ident, NS_SYMBOL | NS_TYPEDEF);
+
 		if (!sym) {
 			sym =3D handle_func(token);
 			if (token->ident =3D=3D &__builtin_types_compatible_p_ident) {
diff --git a/ident-list.h b/ident-list.h
index 83031b265388..31a37bede4ed 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -46,8 +46,11 @@ IDENT(_Thread_local);
 /* C23 keywords */
 IDENT(alignas);
 IDENT(alignof);
+IDENT(bool);
+IDENT(false);
 IDENT(static_assert);
 IDENT(thread_local);
+IDENT(true);
=20
 /* Special case for L'\t' */
 IDENT(L);
diff --git a/parse.c b/parse.c
index d6c23fcdfb5d..4edfed1cdf97 100644
--- a/parse.c
+++ b/parse.c
@@ -520,6 +520,7 @@ static struct init_keyword {
 	N("unsigned",		&unsigned_op),
 	N("__int128",		&int128_op),
 	N("_Bool",		&spec_op,	.type =3D &bool_ctype),
+	N("bool",		&spec_op,	.type =3D &bool_ctype, .std =3D STANDARD_C23),
=20
 	/* Predeclared types */
 	N("__builtin_va_list",	&spec_op,	.type =3D &ptr_ctype),
@@ -655,6 +656,8 @@ void init_parser_finalize(void)
 	if (standard >=3D STANDARD_C23) {
 		static_assert_ident.reserved =3D 1;
 		alignof_ident.reserved =3D 1;
+		true_ident.reserved =3D 1;
+		false_ident.reserved =3D 1;
 	}
 }
=20
diff --git a/pre-process.c b/pre-process.c
index fbe4ba215532..a733927c4c14 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -1937,6 +1937,16 @@ static int expression_value(struct token **where)
 				continue;
 			if (token_type(p) !=3D TOKEN_IDENT)
 				break;
+			if (standard >=3D STANDARD_C23 &&
+			    p->ident =3D=3D &true_ident) {
+				replace_with_bool(p, 1);
+				break;
+			}
+			if (standard >=3D STANDARD_C23 &&
+			    p->ident =3D=3D &false_ident) {
+				replace_with_bool(p, 0);
+				break;
+			}
 			token_type(p) =3D TOKEN_ZERO_IDENT;
 			break;
 		case 1:
diff --git a/validation/c23-bool-error.c b/validation/c23-bool-error.c
new file mode 100644
index 000000000000..49bfafa5bbd1
--- /dev/null
+++ b/validation/c23-bool-error.c
@@ -0,0 +1,23 @@
+static int (bool);
+static int (true);
+static int (false);
+typedef int bool;
+
+static void bad_lvalue(void)
+{
+	true =3D false;
+}
+
+/*
+ * check-name: c23-bool-error
+ * check-command: sparse -std=3Dc23 -Wno-decl $file
+ *
+ * check-error-start
+c23-bool-error.c:1:12: error: Trying to use reserved word 'bool' as iden=
tifier
+c23-bool-error.c:2:12: error: Trying to use reserved word 'true' as iden=
tifier
+c23-bool-error.c:3:12: error: Trying to use reserved word 'false' as ide=
ntifier
+c23-bool-error.c:4:13: error: two or more data types in declaration spec=
ifiers
+c23-bool-error.c:4:13: error: Trying to use reserved word 'bool' as iden=
tifier
+c23-bool-error.c:8:14: error: not an lvalue
+ * check-error-end
+ */
diff --git a/validation/c23-bool.c b/validation/c23-bool.c
new file mode 100644
index 000000000000..8b68b2ad9261
--- /dev/null
+++ b/validation/c23-bool.c
@@ -0,0 +1,45 @@
+#if true
+int t =3D 1;
+#endif
+
+#if !false
+int f =3D 1;
+#endif
+
+#if true + true !=3D 2
+#error "true + true must equal 2 in preprocessor"
+#endif
+
+bool a =3D true;
+bool b =3D false;
+
+struct bool_bf {
+	bool flag : 1;
+};
+
+static_assert(true =3D=3D 1, "true is 1");
+static_assert(false =3D=3D 0, "false is 0");
+static_assert(true + true =3D=3D 2, "integer promotion of true");
+static_assert(sizeof(true) =3D=3D sizeof(bool), "sizeof true is sizeof b=
ool");
+static_assert(sizeof(false) =3D=3D sizeof(bool), "sizeof false is sizeof=
 bool");
+static_assert(_Generic(true, bool: 1, int: 0, default: 0) =3D=3D 1,
+	      "type of true is bool");
+static_assert(_Generic(false, bool: 1, int: 0, default: 0) =3D=3D 1,
+	      "type of false is bool");
+static_assert(_Generic(+true, int: 1, bool: 0, default: 0) =3D=3D 1,
+	      "+true promotes to int");
+
+static int test_conversions(void)
+{
+	bool b1 =3D (bool)0.5;
+	bool b2 =3D (bool)0.0;
+	bool b3 =3D (bool)&a;
+	struct bool_bf s =3D { .flag =3D true };
+
+	return b1 + !b2 + b3 + s.flag;
+}
+
+/*
+ * check-name: c23-bool
+ * check-command: sparse -std=3Dc23 -pedantic -Wno-decl $file
+ */

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256433;
	b=hIL9JO3rtJHSx7StMulpxKPJLKaHjAWFsoVKuT4saRZnrrJc32gFpUaoknjNsBCliXp2
	 lBxl4RYSIEpe8LFiMyYoXcumofMFVC+H8gRssgh3gmRhVtT3yWmKqIIkqLGzh8QohAot7
	 Ss2c2HvsXoptK+hJ/UP50bG3wweB5jmoq0qyGMgrs6zJKgFt0yDOMvOo4oPHkEyyFT1E2
	 CBA08v4Mx1aa4TZXDgGhqEGAQYeiWpw5YC3S0b3d7fbo9Mm13ag7h5CqdVKkt9Fg7wWgX
	 Au35yXd04aJxnxFwc7aVNzJiZ2HyEvBbsj6BKOD+z/OKJLQ2JkSwCbjV6fEimDLYzFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256433;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=oBgvQNX6zrNeL8js37ExuztxIOS5BcTBEjM+8qNWfDw=;
	b=yJ3922GqyhRtVt4rcbvegIeT/o3tjlsekxA6mAtvoICv0P4rd+ZMefNYbMmkW7cqokZ8
	 16+Dct+rMDO6CcLfUCfH0gqOMZFv3axH2yd7ZunndVJrtUZbpEBhTdowLkAKxal2D/uJu
	 E3RFJufu3DsG9guH7Q9bSjmvMLDVVEMADa7Aqzx11kJPATIyG/gBptBKfpeSXIDmoYsUa
	 OuBYtsgC6Ox9/XNSBE4yz4YyljIWOIKkCBTpHP4tSRqOak3K7fb8kXmk/3OmQ9ly/aUVn
	 M310IZiWold51p+P9GG2hr1feDNiyAyj8zp9z4QmIbcuQtC1EcQUWtL9XJpPs/UCFIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=g5pMYf09;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D697D606A325
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D697D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=g5pMYf09
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhMF5RnGz1XMFxH;
	Mon,  9 Nov 2026 20:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256416; x=1796848417; bh=oBgvQ
	NX6zrNeL8js37ExuztxIOS5BcTBEjM+8qNWfDw=; b=g5pMYf095GloP7c7RpsiT
	HzCQgxzDyNe/XCDAUyWrxHapKFvCedW+kvDHoMoe9bN9k2i0U6Xjhra24FBpx960
	xK7pK2hm5aRKy9PElxYj6iXfcm2fPpVCiVyXQp97P2Syo2HvokLeEv/orkvPmnXy
	3Mn3ldjYIWmUlEJVBW/O5Qa1Wh+Gkxh4nsx6TJhNE17Y4+XsjYePuUDTLxLfH04h
	p9ta/e9WQ+mhy8l7MwD9XWxbWdpzaRN6y+nCdavImnr/uzI9qVCfipyBYSuwoRu0
	fQ6j+qzscOCJWKfS827bq4GyAJheXIVcO9NhUmLC6EmRRiEKZ6MMjuARHNsogC7V
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6RvdzoYYEhkT; Mon,  9 Nov 2026 20:33:36 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM270gFz1XMYJl;
	Mon,  9 Nov 2026 20:33:34 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 48/73] c23: Support labels before declarations and at block ends
Date: Mon,  9 Nov 2026 12:32:34 -0800
Message-ID: <20261109203259.362845-49-bvanassche@acm.org>
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

Allow named, case, and default labels (including chained labels) to
precede declarations and closing '}' braces inside compound statements
per ISO C23 6.8.1 and 6.8.2:
- Handle label chains at the block-item level in statement_list() by
  attaching a synthesized empty statement when a label precedes a
  declaration, static_assert, or '}', and emit pedantic warnings in
  pre-C23 modes.
- Keep substatements of selection and iteration statements restricted to
  true statements in statement() so invalid forms such as
  'if (c) int x =3D 1;' and '{ if (c) lbl: }' are rejected cleanly.
- Recognize labels whose identifier shadows an outer typedef name.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 parse.c                          | 206 ++++++++++++++++++++++---------
 validation/c23-labels-error.c    |  48 +++++++
 validation/c23-labels-gnu.c      |  15 +++
 validation/c23-labels-pedantic.c |  15 +++
 validation/c23-labels.c          |  67 ++++++++++
 5 files changed, 296 insertions(+), 55 deletions(-)
 create mode 100644 validation/c23-labels-error.c
 create mode 100644 validation/c23-labels-gnu.c
 create mode 100644 validation/c23-labels-pedantic.c
 create mode 100644 validation/c23-labels.c

diff --git a/parse.c b/parse.c
index 78ad5f09e2ad..1e91825f8d38 100644
--- a/parse.c
+++ b/parse.c
@@ -62,8 +62,6 @@ static declarator_t autotype_specifier;
 static struct token *parse_if_statement(struct token *token, struct stat=
ement *stmt);
 static struct token *parse_return_statement(struct token *token, struct =
statement *stmt);
 static struct token *parse_loop_iterator(struct token *token, struct sta=
tement *stmt);
-static struct token *parse_default_statement(struct token *token, struct=
 statement *stmt);
-static struct token *parse_case_statement(struct token *token, struct st=
atement *stmt);
 static struct token *parse_switch_statement(struct token *token, struct =
statement *stmt);
 static struct token *parse_for_statement(struct token *token, struct sta=
tement *stmt);
 static struct token *parse_while_statement(struct token *token, struct s=
tatement *stmt);
@@ -315,11 +313,9 @@ static struct symbol_op loop_iter_op =3D {
 };
=20
 static struct symbol_op default_op =3D {
-	.statement =3D parse_default_statement,
 };
=20
 static struct symbol_op case_op =3D {
-	.statement =3D parse_case_statement,
 };
=20
 static struct symbol_op switch_op =3D {
@@ -2518,32 +2514,6 @@ static struct token *parse_if_statement(struct tok=
en *token, struct statement *s
 	return statement(token->next, &stmt->if_false);
 }
=20
-static inline struct token *case_statement(struct token *token, struct s=
tatement *stmt)
-{
-	stmt->type =3D STMT_CASE;
-	token =3D expect(token, ':', "after default/case");
-	add_case_statement(stmt);
-	if (match_op(token, '}')) {
-		warning(token->pos, "statement expected after case label");
-		stmt->case_statement =3D alloc_statement(token->pos, STMT_NONE);
-		return token;
-	}
-	return statement(token, &stmt->case_statement);
-}
-
-static struct token *parse_case_statement(struct token *token, struct st=
atement *stmt)
-{
-	token =3D parse_expression(token->next, &stmt->case_expression);
-	if (match_op(token, SPECIAL_ELLIPSIS))
-		token =3D parse_expression(token->next, &stmt->case_to);
-	return case_statement(token, stmt);
-}
-
-static struct token *parse_default_statement(struct token *token, struct=
 statement *stmt)
-{
-	return case_statement(token->next, stmt);
-}
-
 static struct token *parse_loop_iterator(struct token *token, struct sta=
tement *stmt)
 {
 	struct symbol *target =3D lookup_symbol(token->ident, NS_ITERATOR);
@@ -2646,46 +2616,129 @@ static struct token *handle_label_attributes(str=
uct token *token, struct symbol
 	return token;
 }
=20
+static bool is_label_token(struct token *token)
+{
+	struct token *p =3D token;
+	struct symbol *s;
+
+	if (token_type(p) !=3D TOKEN_IDENT)
+		return false;
+	if (p->ident =3D=3D &case_ident || p->ident =3D=3D &default_ident)
+		return true;
+	s =3D lookup_keyword(p->ident, NS_KEYWORD);
+	if (s && s->op->statement)
+		return false;
+	if (p->ident->reserved)
+		return false;
+	return match_op(p->next, ':');
+}
+
+static struct token *parse_one_label(struct token *token,
+				     struct statement **stmtp,
+				     bool *is_case)
+{
+	struct decl_state attr_state =3D { };
+	struct statement *stmt;
+
+	*stmtp =3D NULL;
+	*is_case =3D false;
+
+	if (token->ident =3D=3D &case_ident) {
+		stmt =3D alloc_statement(token->pos, STMT_CASE);
+		token =3D parse_expression(token->next, &stmt->case_expression);
+		if (match_op(token, SPECIAL_ELLIPSIS))
+			token =3D parse_expression(token->next, &stmt->case_to);
+		token =3D expect(token, ':', "after default/case");
+		add_case_statement(stmt);
+		*stmtp =3D stmt;
+		*is_case =3D true;
+		return token;
+	}
+	if (token->ident =3D=3D &default_ident) {
+		stmt =3D alloc_statement(token->pos, STMT_CASE);
+		token =3D expect(token->next, ':', "after default/case");
+		add_case_statement(stmt);
+		*stmtp =3D stmt;
+		*is_case =3D true;
+		return token;
+	}
+
+	{
+		struct position pos =3D token->pos;
+		struct symbol *s =3D label_symbol(token, 0);
+		s->label_modifiers |=3D attr_state.ctype.modifiers;
+		token =3D handle_label_attributes(token->next->next, s);
+		if (s->stmt) {
+			sparse_error(pos, "label '%s' redefined",
+				     show_ident(s->ident));
+			return token;
+		}
+		stmt =3D alloc_statement(pos, STMT_LABEL);
+		stmt->label_identifier =3D s;
+		stmt->label_scope =3D label_scope;
+		if (s->label_scope) {
+			if (!is_in_scope(label_scope, s->label_scope))
+				warn_label_usage(stmt->pos, s->label_pos,
+						 s->ident);
+		}
+		s->stmt =3D stmt;
+		*stmtp =3D stmt;
+		return token;
+	}
+}
+
 static struct token *statement(struct token *token, struct statement **t=
ree)
 {
 	struct statement *stmt =3D alloc_statement(token->pos, STMT_NONE);
=20
+	if (is_label_token(token)) {
+		struct statement *lbl =3D NULL;
+		bool is_case =3D false;
+
+		token =3D parse_one_label(token, &lbl, &is_case);
+		if (!lbl)
+			return statement(token, tree);
+		*tree =3D lbl;
+		tree =3D is_case ? &lbl->case_statement : &lbl->label_statement;
+		if (match_op(token, '}')) {
+			sparse_error(token->pos,
+				     is_case ? "statement expected after case label" :
+					       "statement expected after label");
+			*tree =3D alloc_statement(token->pos, STMT_NONE);
+			return token;
+		}
+		return statement(token, tree);
+	}
+
 	*tree =3D stmt;
 	if (token_type(token) =3D=3D TOKEN_IDENT) {
 		struct symbol *s =3D lookup_keyword(token->ident, NS_KEYWORD);
 		if (s && s->op->statement)
 			return s->op->statement(token, stmt);
-
-		if (match_op(token->next, ':')) {
-			struct symbol *s =3D label_symbol(token, 0);
-			token =3D handle_label_attributes(token->next->next, s);
-			if (s->stmt) {
-				sparse_error(stmt->pos, "label '%s' redefined", show_ident(s->ident)=
);
-				// skip the label to avoid multiple definitions
-				return statement(token, tree);
-			}
-			stmt->type =3D STMT_LABEL;
-			stmt->label_identifier =3D s;
-			stmt->label_scope =3D label_scope;
-			if (s->label_scope) {
-				if (!is_in_scope(label_scope, s->label_scope))
-					warn_label_usage(stmt->pos, s->label_pos, s->ident);
-			}
-			s->stmt =3D stmt;
-			if (match_op(token, '}')) {
-				warning(token->pos, "statement expected after label");
-				stmt->label_statement =3D alloc_statement(token->pos, STMT_NONE);
-				return token;
-			}
-			return statement(token, &stmt->label_statement);
-		}
 	}
=20
 	if (match_op(token, '{')) {
 		token =3D compound_statement(token->next, stmt);
 		return expect(token, '}', "at end of compound statement");
 	}
-		=09
+
+	if (match_ident(token, &_Static_assert_ident) ||
+	    (standard >=3D STANDARD_C23 &&
+	     match_ident(token, &static_assert_ident))) {
+		sparse_error(token->pos, "declaration is not a statement");
+		stmt->type =3D STMT_NONE;
+		return parse_static_assert(token, NULL);
+	}
+
+	if (lookup_type(token)) {
+		sparse_error(token->pos, "declaration is not a statement");
+		stmt->type =3D STMT_DECLARATION;
+		start_block_scope();
+		token =3D external_declaration(token, &stmt->declaration, NULL);
+		end_block_scope();
+		return token;
+	}
+
 	stmt->type =3D STMT_EXPRESSION;
 	return expression_statement(token, &stmt->expression);
 }
@@ -2714,6 +2767,49 @@ static struct token * statement_list(struct token =
*token, struct statement_list
 		token =3D label_statement(token->next);
 	for (;;) {
 		struct statement * stmt;
+		struct statement *label_head =3D NULL;
+		struct statement **label_tail =3D &label_head;
+		bool last_is_case =3D false;
+
+		while (is_label_token(token)) {
+			struct statement *lbl =3D NULL;
+			bool is_case =3D false;
+
+			token =3D parse_one_label(token, &lbl, &is_case);
+			if (!lbl)
+				continue;
+			*label_tail =3D lbl;
+			label_tail =3D is_case ? &lbl->case_statement :
+					       &lbl->label_statement;
+			last_is_case =3D is_case;
+		}
+		if (label_head) {
+			if (eof_token(token) || match_op(token, '}')) {
+				if (standard < STANDARD_C23)
+					warning(token->pos,
+						last_is_case ? "statement expected after case label" :
+							       "statement expected after label");
+				*label_tail =3D alloc_statement(token->pos, STMT_NONE);
+				add_statement(list, label_head);
+				break;
+			}
+			if (match_ident(token, &_Static_assert_ident) ||
+			    (standard >=3D STANDARD_C23 &&
+			     match_ident(token, &static_assert_ident)) ||
+			    lookup_type(token)) {
+				if (standard < STANDARD_C23 && Wpedantic)
+					warning(token->pos,
+						"a label can only be part of a statement and a declaration is not =
a statement");
+				*label_tail =3D alloc_statement(token->pos, STMT_NONE);
+				add_statement(list, label_head);
+			} else {
+				seen_statement =3D Wdeclarationafterstatement;
+				token =3D statement(token, label_tail);
+				add_statement(list, label_head);
+				continue;
+			}
+		}
+
 		if (eof_token(token))
 			break;
 		if (match_op(token, '}'))
diff --git a/validation/c23-labels-error.c b/validation/c23-labels-error.=
c
new file mode 100644
index 000000000000..55ee5bfd5b47
--- /dev/null
+++ b/validation/c23-labels-error.c
@@ -0,0 +1,48 @@
+static void test_dup(void)
+{
+dup:
+	;
+dup:
+	;
+}
+
+static void test_if_decl(int c)
+{
+	if (c)
+		int x =3D 1;
+}
+
+static void test_if_label_decl(int c)
+{
+	if (c)
+	lbl1:
+		int y =3D 2;
+}
+
+static void test_if_label_end(int c)
+{
+	if (c)
+	lbl2:
+}
+
+static void test_outside_switch(void)
+{
+	case 1:
+		;
+	default:
+		;
+}
+
+/*
+ * check-name: c23-labels-error
+ * check-command: sparse -std=3Dc23 -Wno-decl $file
+ *
+ * check-error-start
+c23-labels-error.c:5:1: error: label 'dup' redefined
+c23-labels-error.c:12:17: error: declaration is not a statement
+c23-labels-error.c:19:17: error: declaration is not a statement
+c23-labels-error.c:26:1: error: statement expected after label
+c23-labels-error.c:30:9: error: not in switch scope
+c23-labels-error.c:32:9: error: not in switch scope
+ * check-error-end
+ */
diff --git a/validation/c23-labels-gnu.c b/validation/c23-labels-gnu.c
new file mode 100644
index 000000000000..15dcb20be1d8
--- /dev/null
+++ b/validation/c23-labels-gnu.c
@@ -0,0 +1,15 @@
+static int test_gnu_case_range(int c)
+{
+	switch (c) {
+	case 1 ... 5:
+		int a =3D 3;
+		return a;
+	case 6 ... 9:
+	}
+	return 0;
+}
+
+/*
+ * check-name: c23-labels-gnu
+ * check-command: sparse -std=3Dgnu23 -Wno-decl $file
+ */
diff --git a/validation/c23-labels-pedantic.c b/validation/c23-labels-ped=
antic.c
new file mode 100644
index 000000000000..6048f2e48e96
--- /dev/null
+++ b/validation/c23-labels-pedantic.c
@@ -0,0 +1,15 @@
+static void test_label_decl(void)
+{
+	goto lbl;
+lbl:
+	int x =3D 42;
+}
+
+/*
+ * check-name: c23-labels-pedantic
+ * check-command: sparse -std=3Dc11 -pedantic -Wno-decl $file
+ *
+ * check-error-start
+c23-labels-pedantic.c:5:9: warning: a label can only be part of a statem=
ent and a declaration is not a statement
+ * check-error-end
+ */
diff --git a/validation/c23-labels.c b/validation/c23-labels.c
new file mode 100644
index 000000000000..b4d90edbe666
--- /dev/null
+++ b/validation/c23-labels.c
@@ -0,0 +1,67 @@
+typedef int T_shadow;
+
+static int test_label_decl(void)
+{
+	goto lbl;
+lbl:
+lbl_chain:
+	int x =3D 42;
+	if (!x)
+		goto lbl_chain;
+	return x;
+}
+
+static int test_case_decl(int c)
+{
+	switch (c) {
+	case 1:
+		int a =3D 10;
+		return a;
+	default:
+		int b =3D 20;
+		return b;
+	}
+}
+
+static void test_label_end(int c)
+{
+	if (c =3D=3D 1)
+		goto end1;
+	if (c =3D=3D 2)
+		goto end2;
+end1:
+end2:
+}
+
+static void test_case_end(int c)
+{
+	switch (c) {
+	case 0:
+	case 1:
+	}
+	switch (c) {
+	default:
+	}
+}
+
+static void test_label_static_assert(void)
+{
+	goto lbl2;
+lbl2:
+	static_assert(1, "");
+}
+
+static int test_typedef_shadow_label(int c)
+{
+	if (c)
+		goto T_shadow;
+	return 0;
+T_shadow:
+	int v =3D 1;
+	return v;
+}
+
+/*
+ * check-name: c23-labels
+ * check-command: sparse -std=3Dc23 -pedantic -Wno-decl $file
+ */

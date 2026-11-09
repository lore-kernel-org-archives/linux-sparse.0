Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256440;
	b=w0NWCIOfZpRESLZ+ZIJ5g3kpz/PCVL1jGOqmACpMu/a7y3B0Tqqxv4XPDXCSXNoRXYnW
	 iLUbUNvzI7dGIpeq8NWoX4OGm5TW/uWFr8nn24n7htwmQo0UsSsiUwaPQ6Mj/PkyoZBu9
	 JOfr7nNgu8bxIVwXybfFAufEAhC9sHpB7YlFhLxVfJ3UcFrxaskB68cZnDz7+jlUuG+gW
	 nytbJLZbjQTUjU1HfuYE7gzEV4faQGqN39wM+QzlFu3j54eVh0iq6BiDRt6k8Ni6D6WW5
	 wqzPXeShTlJvDvOxcEta4y8+hFPftPGarngmmwAO3SnLxGp5WWv7yRYcNU8OYNjZ3Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=w8TvLavYFfyjdvkH778s6W0pZm7aJmklVKoQ/TEWObo=;
	b=wFl0QnD57cAGbJbkTi5YDvBX7oiTnR2wo5Ka/xmiglKZlMMRHCfyIwXUNpNooQY+tpvN
	 gnmGJ+uqQ1MGFW/HPVQuYW+YAq8z9Va7vW48SStZdJ2CLlHLKfho8fJyrIJp3lzrKlqZZ
	 i1Zvxiww8QnMK0uV4Sdlsz/acyjlVEOU7rICAlQi8qCsB6VtHbq9j3FFqE4QFJTItdl8h
	 ztT9IICOhcQ+B1F/TbBN429nVOhWZse0BJpVJAnxltExHbtTx3trkC97iS4VFsGXdnVAj
	 PIWX/uuH5igSk5zeFWvS7UiSIZm0EIVEHZw2uRvS1qWZz+72zw+MBgfktvJc9V7sfXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=SdGj3d3k;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629EB606A326
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 629EB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=SdGj3d3k
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhML6GTJz1XMYJX;
	Mon,  9 Nov 2026 20:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256416; x=1796848417; bh=w8TvL
	avYFfyjdvkH778s6W0pZm7aJmklVKoQ/TEWObo=; b=SdGj3d3kdKo5ccwMkXc3A
	5jcicygHO/S0y8BHD7CEf6iHep9R/dhvKzP/JakUugxgy9wP1qMBeuOjK4sT7CQe
	MkuZGqxlR1rM/PJFLUS4BR7e8Hh2bA3mzh9rmGuhpFH8NIsuWln5uoPgW6FGHvc2
	pGRCf0/zs/Zm0GGMrL0Z8oAhONUCQkYF8wEqYXsaSyPezkjzfk3xo2N4zG/oCJ8m
	VqOwUVXZ00//QqWzmqJkz43p2VWPuhws8ajhl0IcRZVB1LgY0JVdhRfKNpWAUFqn
	dbxlDqmV34LblmUBts5mrCRtqz4uBn3HlrJOMM83ED5Vg56ZaDl1vZFubxYROFx/
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id J0w7sVSBeo_U; Mon,  9 Nov 2026 20:33:36 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM20kHlz1XM6J7;
	Mon,  9 Nov 2026 20:33:34 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 44/73] c23: Add support for nullptr and nullptr_t
Date: Mon,  9 Nov 2026 12:32:30 -0800
Message-ID: <20261109203259.362845-45-bvanassche@acm.org>
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

Introduce the reserved C23 nullptr keyword and a dedicated nullptr_ctype
base type representing nullptr_t per ISO C23 6.2.5 and 6.3.2.3:
- Evaluate nullptr as an address constant of type nullptr_ctype rather
  than an integer constant expression, rejecting nullptr in array bounds,
  enumerators, and switch controlling expressions.
- Support implicit and explicit conversions from nullptr_t expressions to
  any pointer type and bool, equality comparisons with pointers and null
  pointer constants, conditional expressions, _Generic associations, and
  variadic arguments, while rejecting relational comparisons, arithmetic,
  and non-bool/non-void/non-pointer casts.
- Lower nullptr_ctype as a pointer-sized null value in linearize and
  sparse-llvm.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 evaluate.c                       | 186 +++++++++++++++++++++++++++++--
 expression.c                     |  10 ++
 ident-list.h                     |   1 +
 linearize.c                      |   2 +
 parse.c                          |   7 ++
 show-parse.c                     |   1 +
 sparse-llvm.c                    |  26 +++--
 symbol.c                         |  12 +-
 symbol.h                         |  13 ++-
 validation/backend/c23-nullptr.c |  21 ++++
 validation/c23-nullptr-assign.c  |  35 ++++++
 validation/c23-nullptr-error.c   | 107 ++++++++++++++++++
 validation/c23-nullptr.c         | 107 ++++++++++++++++++
 validation/linear/c23-nullptr.c  |  20 ++++
 14 files changed, 528 insertions(+), 20 deletions(-)
 create mode 100644 validation/backend/c23-nullptr.c
 create mode 100644 validation/c23-nullptr-assign.c
 create mode 100644 validation/c23-nullptr-error.c
 create mode 100644 validation/c23-nullptr.c
 create mode 100644 validation/linear/c23-nullptr.c

diff --git a/evaluate.c b/evaluate.c
index ec02e5bbc4fe..c0d039105881 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -857,6 +857,8 @@ const char *type_difference(struct ctype *c1, struct =
ctype *c2,
 				return "different address spaces";
 			if (base1 !=3D base2)
 				return "different base types";
+			if (!base1 && t1->bit_size !=3D t2->bit_size)
+				return "different base types";
 			if (t1->rank !=3D t2->rank)
 				return "different type sizes";
 			diff =3D (mod1 ^ mod2) & ~MOD_IGNORE;
@@ -1106,7 +1108,11 @@ enum null_constant_type {
=20
 static inline int is_null_pointer_constant(struct expression *e)
 {
-	if (e->ctype =3D=3D &null_ctype)
+	if (e->ctype =3D=3D &null_ctype ||
+	    (e->ctype && e->ctype->type =3D=3D SYM_NODE && e->ctype->ctype.base=
_type =3D=3D &null_ctype))
+		return NULL_PTR;
+	if (is_nullptr_type(e->ctype) &&
+	    (e->type =3D=3D EXPR_VALUE || (e->flags & CEF_ADDR)))
 		return NULL_PTR;
 	if (!(e->flags & CEF_ICE))
 		return NON_NULL;
@@ -1148,6 +1154,87 @@ static struct symbol *evaluate_compare(struct expr=
ession *expr)
 		goto OK;
 	}
=20
+	/* nullptr_t equality comparisons [C23 6.5.9] */
+	if (ltype =3D=3D &nullptr_ctype || rtype =3D=3D &nullptr_ctype) {
+		int is_null1, is_null2;
+
+		if (expr->op !=3D SPECIAL_EQUAL && expr->op !=3D SPECIAL_NOTEQUAL)
+			return bad_expr_type(expr);
+
+		is_null1 =3D is_null_pointer_constant(left);
+		is_null2 =3D is_null_pointer_constant(right);
+		if (ltype =3D=3D &nullptr_ctype && rtype =3D=3D &nullptr_ctype) {
+			if (is_null1 && is_null2) {
+				expr->type =3D EXPR_VALUE;
+				expr->value =3D (expr->op =3D=3D SPECIAL_EQUAL);
+				expr->flags |=3D CEF_ACE;
+			}
+			goto OK;
+		}
+		if (ltype =3D=3D &nullptr_ctype) {
+			if (rclass & TYPE_PTR) {
+				if (is_null1 && is_null2) {
+					if (is_null2 =3D=3D NULL_ZERO)
+						bad_null(right);
+					expr->type =3D EXPR_VALUE;
+					expr->value =3D (expr->op =3D=3D SPECIAL_EQUAL);
+					expr->flags |=3D CEF_ACE;
+					goto OK;
+				}
+				if (rtype =3D=3D &null_ctype) {
+					expr->left =3D cast_to(left, &ptr_ctype);
+					expr->right =3D cast_to(right, &ptr_ctype);
+				} else {
+					expr->left =3D cast_to(left, rtype);
+				}
+				goto OK;
+			}
+			if (is_null2) {
+				if (is_null2 =3D=3D NULL_ZERO)
+					bad_null(right);
+				if (is_null1) {
+					expr->type =3D EXPR_VALUE;
+					expr->value =3D (expr->op =3D=3D SPECIAL_EQUAL);
+					expr->flags |=3D CEF_ACE;
+				} else {
+					expr->right =3D cast_to(right, &nullptr_ctype);
+				}
+				goto OK;
+			}
+			return bad_expr_type(expr);
+		}
+		if (lclass & TYPE_PTR) {
+			if (is_null1 && is_null2) {
+				if (is_null1 =3D=3D NULL_ZERO)
+					bad_null(left);
+				expr->type =3D EXPR_VALUE;
+				expr->value =3D (expr->op =3D=3D SPECIAL_EQUAL);
+				expr->flags |=3D CEF_ACE;
+				goto OK;
+			}
+			if (ltype =3D=3D &null_ctype) {
+				expr->left =3D cast_to(left, &ptr_ctype);
+				expr->right =3D cast_to(right, &ptr_ctype);
+			} else {
+				expr->right =3D cast_to(right, ltype);
+			}
+			goto OK;
+		}
+		if (is_null1) {
+			if (is_null1 =3D=3D NULL_ZERO)
+				bad_null(left);
+			if (is_null2) {
+				expr->type =3D EXPR_VALUE;
+				expr->value =3D (expr->op =3D=3D SPECIAL_EQUAL);
+				expr->flags |=3D CEF_ACE;
+			} else {
+				expr->left =3D cast_to(left, &nullptr_ctype);
+			}
+			goto OK;
+		}
+		return bad_expr_type(expr);
+	}
+
 	/* at least one must be a pointer */
 	if (!((lclass | rclass) & TYPE_PTR))
 		return bad_expr_type(expr);
@@ -1276,6 +1363,29 @@ static struct symbol *evaluate_conditional_express=
ion(struct expression *expr)
 		goto out;
 	}
=20
+	if (ltype =3D=3D &nullptr_ctype || rtype =3D=3D &nullptr_ctype) {
+		if (ltype =3D=3D &nullptr_ctype && rtype =3D=3D &nullptr_ctype) {
+			ctype =3D &nullptr_ctype;
+			goto out;
+		}
+		if (ltype =3D=3D &nullptr_ctype && (rclass & TYPE_PTR)) {
+			ctype =3D (rtype =3D=3D &null_ctype) ? &ptr_ctype : rtype;
+			*cond =3D cast_to(*cond, ctype);
+			if (rtype =3D=3D &null_ctype)
+				expr->cond_false =3D cast_to(expr->cond_false, ctype);
+			goto out;
+		}
+		if (rtype =3D=3D &nullptr_ctype && (lclass & TYPE_PTR)) {
+			ctype =3D (ltype =3D=3D &null_ctype) ? &ptr_ctype : ltype;
+			if (ltype =3D=3D &null_ctype)
+				*cond =3D cast_to(*cond, ctype);
+			expr->cond_false =3D cast_to(expr->cond_false, ctype);
+			goto out;
+		}
+		typediff =3D "different types";
+		goto Err;
+	}
+
 	if ((lclass | rclass) & TYPE_PTR) {
 		int is_null1 =3D is_null_pointer_constant(*cond);
 		int is_null2 =3D is_null_pointer_constant(expr->cond_false);
@@ -1486,6 +1596,20 @@ static int check_assignment_types(struct symbol *t=
arget, struct expression **rp,
 	int tclass =3D classify_type(target, &t);
 	int sclass =3D classify_type(source, &s);
=20
+	if (t =3D=3D &nullptr_ctype) {
+		int is_null;
+		if (s =3D=3D &nullptr_ctype)
+			return 1;
+		is_null =3D is_null_pointer_constant(*rp);
+		if (is_null) {
+			if (is_null =3D=3D NULL_ZERO)
+				bad_null(*rp);
+			goto Cast;
+		}
+		*typediff =3D "different base types";
+		return 0;
+	}
+
 	if (tclass & sclass & TYPE_NUM) {
 		if (tclass & TYPE_RESTRICT) {
 			/* allowed assignments unfoul */
@@ -1518,10 +1642,21 @@ static int check_assignment_types(struct symbol *=
target, struct expression **rp,
 				bad_null(*rp);
 			goto Cast;
 		}
+		if (s =3D=3D &nullptr_ctype) {
+			if (t =3D=3D &null_ctype) {
+				*typediff =3D "different base types";
+				return 0;
+			}
+			goto Cast;
+		}
 		if (!(sclass & TYPE_PTR)) {
 			*typediff =3D "different base types";
 			return 0;
 		}
+		if (t =3D=3D &null_ctype && s !=3D &null_ctype) {
+			*typediff =3D "different base types";
+			return 0;
+		}
 		b1 =3D examine_pointer_target(t);
 		b2 =3D examine_pointer_target(s);
 		mod1 =3D t->ctype.modifiers & (MOD_IGN | MOD_NODEREF);
@@ -1566,7 +1701,7 @@ static int check_assignment_types(struct symbol *ta=
rget, struct expression **rp,
=20
 	if (tclass & TYPE_NUM) {
 		/* XXX: need to turn into comparison with NULL */
-		if (is_bool_type(t) && (sclass & TYPE_PTR))
+		if (is_bool_type(t) && ((sclass & TYPE_PTR) || s =3D=3D &nullptr_ctype=
))
 			goto Cast;
 		*typediff =3D "different base types";
 		return 0;
@@ -2067,9 +2202,13 @@ static struct symbol *evaluate_preop(struct expres=
sion *expr)
 		expr->flags =3D expr->unop->flags & ~CEF_CONST_MASK;
 		/*
 		 * A logical negation never yields an address constant
-		 * [6.6(9)].
+		 * [6.6(9)], though negating an address constant yields
+		 * an arithmetic constant expression.
 		 */
-		expr->flags &=3D ~CEF_ADDR;
+		if (expr->unop->flags & CEF_ADDR) {
+			expr->flags &=3D ~CEF_ADDR;
+			expr->flags |=3D CEF_ACE;
+		}
=20
 		if (is_safe_type(ctype))
 			warning(expr->pos, "testing a 'safe expression'");
@@ -2474,6 +2613,8 @@ int evaluate_arguments(struct symbol_list *argtypes=
, struct expression_list *hea
 					*p =3D cast_to(expr, &ptr_ctype);
 				else
 					degenerate(expr);
+			} else if (type =3D=3D &nullptr_ctype) {
+				degenerate(expr);
 			}
 		} else if (!target->forced_arg){
 			static char where[30];
@@ -2984,6 +3125,14 @@ static struct symbol *cast_to_bool(struct expressi=
on *expr)
 		return NULL;
=20
 	zero =3D alloc_const_expression(expr->pos, 0);
+	if (otype =3D=3D &nullptr_ctype) {
+		zero->ctype =3D otype;
+		expr->op =3D SPECIAL_NOTEQUAL;
+		expr->type =3D EXPR_COMPARE;
+		expr->left =3D old;
+		expr->right =3D zero;
+		return expr->ctype;
+	}
 	if (oclass & TYPE_PTR)
 		zero->ctype =3D otype;
 	expr->op =3D SPECIAL_NOTEQUAL;
@@ -3030,7 +3179,7 @@ static int cast_flags(struct expression *expr, stru=
ct expression *old)
 		 */
 		else if (old->flags & CEF_FLOAT)
 			flags =3D CEF_SET_ICE;
-	} else if (class & TYPE_PTR) {
+	} else if ((class & TYPE_PTR) || t =3D=3D &nullptr_ctype) {
 		/*
 		 * Casts of integer literals to pointer type yield
 		 * address constants [6.6(9)].
@@ -3145,6 +3294,19 @@ static struct symbol *evaluate_cast(struct express=
ion *expr)
 	if (expr->type =3D=3D EXPR_FORCE_CAST)
 		goto out;
=20
+	if (ttype =3D=3D &nullptr_ctype) {
+		if (stype !=3D &nullptr_ctype && !is_null_pointer_constant(source))
+			expression_error(expr, "conversion from '%s' to 'nullptr_t'",
+					 show_typename(source->ctype));
+		goto out;
+	}
+	if (stype =3D=3D &nullptr_ctype) {
+		if (!is_bool_type(ttype) && tclass !=3D TYPE_PTR)
+			expression_error(expr, "conversion from 'nullptr_t' to '%s'",
+					 show_typename(ctype));
+		goto out;
+	}
+
 	if (tclass & (TYPE_COMPOUND | TYPE_FN)) {
 		/*
 		 * Special case: cast to union type (GCC extension)
@@ -3471,8 +3633,13 @@ static struct symbol *evaluate_generic_selection(s=
truct expression *expr)
 		return NULL;
 	}
=20
-	source =3D *ctrl;
-	source.ctype.modifiers &=3D ~(MOD_QUALIFIER|MOD_ATOMIC);
+	struct symbol *sel_ctrl =3D ctrl;
+
+	if (ctrl->ctype.modifiers & (MOD_QUALIFIER|MOD_ATOMIC)) {
+		source =3D *ctrl;
+		source.ctype.modifiers &=3D ~(MOD_QUALIFIER|MOD_ATOMIC);
+		sel_ctrl =3D &source;
+	}
 	for (map =3D expr->map; map; map =3D map->next) {
 		struct symbol *stype =3D map->type;
 		struct symbol *base;
@@ -3509,7 +3676,7 @@ static struct symbol *evaluate_generic_selection(st=
ruct expression *expr)
 			sparse_error(stype->pos, "incomplete type in generic selection");
 			continue;
 		}
-		if (!type_selection(&source, stype))
+		if (!type_selection(sel_ctrl, stype))
 			continue;
=20
 		res =3D map->expr;
@@ -4009,6 +4176,9 @@ static void evaluate_switch_statement(struct statem=
ent *stmt)
 	evaluate_statement(stmt->switch_statement);
 	if (!sel)
 		return;
+	if (valid_type(sel->ctype) && !is_int_type(sel->ctype) &&
+	    !is_restricted_type(sel->ctype) && !is_fouled_type(sel->ctype))
+		expression_error(sel, "switch quantity is not an integer");
 	if (sel->ctype && is_enum_type(sel->ctype))
 		enumcase_holder =3D NULL; /* Only check cases against switch */
=20
diff --git a/expression.c b/expression.c
index 9b07963c914a..da2c14b458db 100644
--- a/expression.c
+++ b/expression.c
@@ -480,6 +480,16 @@ struct token *primary_expression(struct token *token=
, struct expression **tree)
 			break;
 		}
=20
+		if (standard >=3D STANDARD_C23 &&
+		    token->ident =3D=3D &nullptr_ident) {
+			expr =3D alloc_expression(token->pos, EXPR_VALUE);
+			expr->flags =3D CEF_ADDR;
+			expr->ctype =3D &nullptr_ctype;
+			expr->value =3D 0;
+			token =3D next;
+			break;
+		}
+
 		sym =3D lookup_symbol(token->ident, NS_SYMBOL | NS_TYPEDEF);
=20
 		if (!sym) {
diff --git a/ident-list.h b/ident-list.h
index 31a37bede4ed..18dabf5193b2 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -48,6 +48,7 @@ IDENT(alignas);
 IDENT(alignof);
 IDENT(bool);
 IDENT(false);
+IDENT(nullptr);
 IDENT(static_assert);
 IDENT(thread_local);
 IDENT(true);
diff --git a/linearize.c b/linearize.c
index bb3a5a9ecf16..422cee820ddb 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1276,6 +1276,8 @@ retry:	switch (s->type) {
 	case_int:
 		return sign ? MTYPE_SINT : MTYPE_UINT;
 	case SYM_BASETYPE:
+		if (s =3D=3D &nullptr_ctype)
+			return MTYPE_VPTR;
 		if (s->ctype.base_type =3D=3D &fp_type)
 			return MTYPE_FLOAT;
 		if (s->ctype.base_type =3D=3D &int_type)
diff --git a/parse.c b/parse.c
index 4edfed1cdf97..5e526b0cc840 100644
--- a/parse.c
+++ b/parse.c
@@ -658,6 +658,7 @@ void init_parser_finalize(void)
 		alignof_ident.reserved =3D 1;
 		true_ident.reserved =3D 1;
 		false_ident.reserved =3D 1;
+		nullptr_ident.reserved =3D 1;
 	}
 }
=20
@@ -1006,6 +1007,12 @@ static struct token *parse_enum_declaration(struct=
 token *token, struct symbol *
 			ctype =3D &void_ctype;
 			if (expr && expr->ctype)
 				ctype =3D expr->ctype;
+			if (is_nullptr_type(ctype)) {
+				sparse_error(expr->pos,
+					     "enumerator value for '%s' is not an integer constant",
+					     show_ident(token->ident));
+				ctype =3D &int_ctype;
+			}
 		} else if (!ctype) {
 			ctype =3D &int_ctype;
 		} else if (is_int_type(ctype)) {
diff --git a/show-parse.c b/show-parse.c
index 850d6ce5f937..78d86e20e93a 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -278,6 +278,7 @@ static struct ctype_name {
=20
 	{ &void_ctype,   "void", "" },
 	{ &bool_ctype,   "bool", "" },
+	{ &nullptr_ctype, "nullptr_t", "" },
=20
 	{ &float_ctype,  "float", "F" },
 	{ &double_ctype, "double", "" },
diff --git a/sparse-llvm.c b/sparse-llvm.c
index 8f37bde1b98d..c7055238ff88 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -154,6 +154,9 @@ static LLVMTypeRef sym_basetype_type(struct symbol *s=
ym)
 {
 	LLVMTypeRef ret =3D NULL;
=20
+	if (sym =3D=3D &nullptr_ctype)
+		return LLVMPointerType(LLVMInt8TypeInContext(context), 0);
+
 	if (is_float_type(sym)) {
 		switch (sym->bit_size) {
 		case 32:
@@ -458,12 +461,17 @@ static LLVMValueRef value_to_ivalue(struct function=
 *fn, struct symbol *ctype, L
 	return val;
 }
=20
+static inline bool is_llvm_ptr_type(struct symbol *type)
+{
+	return is_ptr_type(type) || is_nullptr_type(type);
+}
+
 static LLVMValueRef value_to_pvalue(struct function *fn, struct symbol *=
ctype, LLVMValueRef val)
 {
 	const char *name =3D LLVMGetValueName(val);
 	LLVMTypeRef dtype =3D symbol_type(ctype);
=20
-	assert(is_ptr_type(ctype));
+	assert(is_llvm_ptr_type(ctype));
 	switch (LLVMGetTypeKind(LLVMTypeOf(val))) {
 	case LLVMIntegerTypeKind:
 		val =3D LLVMBuildIntToPtr(fn->builder, val, dtype, name);
@@ -481,7 +489,7 @@ static LLVMValueRef adjust_type(struct function *fn, =
struct symbol *ctype, LLVMV
 {
 	if (is_int_type(ctype))
 		return value_to_ivalue(fn, ctype, val);
-	if (is_ptr_type(ctype))
+	if (is_llvm_ptr_type(ctype))
 		return value_to_pvalue(fn, ctype, val);
 	return val;
 }
@@ -901,18 +909,18 @@ static void output_op_ptrcast(struct function *fn, =
struct instruction *insn)
 	case OP_UTPTR:
 	case OP_SEXT:			// FIXME
 		assert(is_int_type(otype));
-		assert(is_ptr_type(insn->type));
+		assert(is_llvm_ptr_type(insn->type));
 		op =3D LLVMIntToPtr;
 		break;
 	case OP_PTRTU:
-		assert(is_ptr_type(otype));
+		assert(is_llvm_ptr_type(otype));
 		assert(is_int_type(insn->type));
 		op =3D LLVMPtrToInt;
 		break;
 	case OP_PTRCAST:
 	case OP_ZEXT:			// FIXME
-		assert(is_ptr_type(otype));
-		assert(is_ptr_type(insn->type));
+		assert(is_llvm_ptr_type(otype));
+		assert(is_llvm_ptr_type(insn->type));
 		op =3D LLVMBitCast;
 		break;
 	default:
@@ -930,7 +938,7 @@ static void output_op_cast(struct function *fn, struc=
t instruction *insn, LLVMOp
 	struct symbol *otype =3D insn->orig_type;
 	char target_name[64];
=20
-	if (is_ptr_type(insn->type))	// cast to void* is OP_CAST ...
+	if (is_llvm_ptr_type(insn->type))	// cast to void* is OP_CAST ...
 		return output_op_ptrcast(fn, insn);
=20
 	assert(is_int_type(insn->type));
@@ -939,7 +947,7 @@ static void output_op_cast(struct function *fn, struc=
t instruction *insn, LLVMOp
 	pseudo_name(insn->target, target_name);
=20
 	dtype =3D symbol_type(insn->type);
-	if (is_ptr_type(otype)) {
+	if (is_llvm_ptr_type(otype)) {
 		op =3D LLVMPtrToInt;
 	} else if (is_float_type(otype)) {
 		assert(op =3D=3D LLVMFPToUI || op =3D=3D LLVMFPToSI);
@@ -1252,7 +1260,7 @@ static LLVMValueRef output_data(LLVMModuleRef modul=
e, struct symbol *sym)
 	if (initializer) {
 		switch (initializer->type) {
 		case EXPR_VALUE:
-			initial_value =3D LLVMConstInt(symbol_type(sym), initializer->value, =
1);
+			initial_value =3D constant_value(initializer->value, symbol_type(sym)=
);
 			break;
 		case EXPR_FVALUE:
 			initial_value =3D LLVMConstReal(symbol_type(sym), initializer->fvalue=
);
diff --git a/symbol.c b/symbol.c
index 06cd8ca2ede7..a05e240cdfaa 100644
--- a/symbol.c
+++ b/symbol.c
@@ -307,7 +307,14 @@ static struct symbol * examine_array_type(struct sym=
bol *sym)
 		unsigned long count =3D get_expression_value_silent(array_size);
 		if (base_type->bit_size >=3D 0)
 			bit_size =3D array_element_offset(base_type->bit_size, count);
-		if (array_size->type !=3D EXPR_VALUE) {
+		if (valid_type(array_size->ctype) &&
+		    !is_int_type(array_size->ctype) &&
+		    !is_restricted_type(array_size->ctype) &&
+		    !is_fouled_type(array_size->ctype)) {
+			sparse_error(array_size->pos,
+				     "size of array has non-integer type");
+			bit_size =3D 0;
+		} else if (array_size->type !=3D EXPR_VALUE) {
 			if (Wvla)
 				warning(array_size->pos, "Variable length array is used.");
 			bit_size =3D -1;
@@ -875,7 +882,7 @@ struct symbol	bool_ctype, void_ctype, type_ctype,
 		float_ctype, double_ctype, ldouble_ctype,
 		string_ctype, ptr_ctype, lazy_ptr_ctype,
 		incomplete_ctype, label_ctype, bad_ctype,
-		null_ctype;
+		null_ctype, nullptr_ctype;
 struct symbol	autotype_ctype;
 struct symbol	schar_ptr_ctype, short_ptr_ctype;
 struct symbol	int_ptr_ctype, uint_ptr_ctype;
@@ -942,6 +949,7 @@ static const struct ctype_declare {
 	{ &incomplete_ctype,   T_BASETYPE },
 	{ &autotype_ctype,     T_BASETYPE },
 	{ &bad_ctype,          T_BASETYPE },
+	{ &nullptr_ctype,      SYM_BASETYPE, 0, 0, &bits_in_pointer, &pointer_a=
lignment, NULL },
=20
 	{ &char_ctype,         T__INT(-2, char) },
 	{ &schar_ctype,        T_SINT(-2, char) },
diff --git a/symbol.h b/symbol.h
index 2c6731f88399..acd381fe64fd 100644
--- a/symbol.h
+++ b/symbol.h
@@ -306,7 +306,7 @@ extern struct symbol	bool_ctype, void_ctype, type_cty=
pe,
 			float_ctype, double_ctype, ldouble_ctype,
 			string_ctype, ptr_ctype, lazy_ptr_ctype,
 			incomplete_ctype, label_ctype, bad_ctype,
-			null_ctype;
+			null_ctype, nullptr_ctype;
 extern struct symbol	autotype_ctype;
 extern struct symbol	schar_ptr_ctype, short_ptr_ctype;
 extern struct symbol	int_ptr_ctype, uint_ptr_ctype;
@@ -487,6 +487,13 @@ static inline int is_bool_type(struct symbol *type)
 	return type =3D=3D &bool_ctype;
 }
=20
+static inline int is_nullptr_type(const struct symbol *type)
+{
+	if (type && type->type =3D=3D SYM_NODE)
+		type =3D type->ctype.base_type;
+	return type =3D=3D &nullptr_ctype;
+}
+
 static inline int is_scalar_type(struct symbol *type)
 {
 	if (type->type =3D=3D SYM_NODE)
@@ -505,6 +512,8 @@ static inline int is_scalar_type(struct symbol *type)
 		return 1;
 	if (type->ctype.base_type =3D=3D &fp_type)
 		return 1;
+	if (type =3D=3D &nullptr_ctype)
+		return 1;
 	return 0;
 }
=20
@@ -524,6 +533,8 @@ static inline bool is_integral_type(struct symbol *ty=
pe)
 	}
 	if (type->ctype.base_type =3D=3D &int_type)
 		return 1;
+	if (type =3D=3D &nullptr_ctype)
+		return 1;
 	return 0;
 }
=20
diff --git a/validation/backend/c23-nullptr.c b/validation/backend/c23-nu=
llptr.c
new file mode 100644
index 000000000000..2cfb27b19f47
--- /dev/null
+++ b/validation/backend/c23-nullptr.c
@@ -0,0 +1,21 @@
+typedef typeof(nullptr) nullptr_t;
+
+extern int sink(const char *fmt, ...);
+
+static nullptr_t g_np =3D nullptr;
+
+int test_nullptr_llvm(nullptr_t arg, int **out);
+int test_nullptr_llvm(nullptr_t arg, int **out)
+{
+	*out =3D arg;
+	g_np =3D nullptr;
+	return sink("test", nullptr, arg, g_np);
+}
+
+/*
+ * check-name: backend-c23-nullptr
+ * check-command: sparse-llvm-dis -m64 -std=3Dc23 $file
+ * check-output-ignore
+ * check-output-contains: define i32 @test_nullptr_llvm(
+ * check-output-contains: @sink(
+ */
diff --git a/validation/c23-nullptr-assign.c b/validation/c23-nullptr-ass=
ign.c
new file mode 100644
index 000000000000..e863075f2103
--- /dev/null
+++ b/validation/c23-nullptr-assign.c
@@ -0,0 +1,35 @@
+typedef typeof(nullptr) nullptr_t;
+
+void test(int *p, void *v)
+{
+	nullptr_t np;
+	np =3D p;
+	np =3D v;
+	np =3D 0;
+
+	int i =3D nullptr;
+	double d =3D np;
+	(void)i;
+	(void)d;
+}
+
+/*
+ * check-name: c23-nullptr-assign
+ * check-command: sparse -std=3Dc23 -Wno-decl $file
+ *
+ * check-error-start
+c23-nullptr-assign.c:6:12: warning: incorrect type in assignment (differ=
ent base types)
+c23-nullptr-assign.c:6:12:    expected nullptr_t [usertype] np
+c23-nullptr-assign.c:6:12:    got int *p
+c23-nullptr-assign.c:7:12: warning: incorrect type in assignment (differ=
ent base types)
+c23-nullptr-assign.c:7:12:    expected nullptr_t [usertype] np
+c23-nullptr-assign.c:7:12:    got void *v
+c23-nullptr-assign.c:8:14: warning: Using plain integer as NULL pointer
+c23-nullptr-assign.c:10:17: warning: incorrect type in initializer (diff=
erent base types)
+c23-nullptr-assign.c:10:17:    expected int i
+c23-nullptr-assign.c:10:17:    got nullptr_t
+c23-nullptr-assign.c:11:20: warning: incorrect type in initializer (diff=
erent base types)
+c23-nullptr-assign.c:11:20:    expected double d
+c23-nullptr-assign.c:11:20:    got nullptr_t [assigned] [usertype] np
+ * check-error-end
+ */
diff --git a/validation/c23-nullptr-error.c b/validation/c23-nullptr-erro=
r.c
new file mode 100644
index 000000000000..1e26878519a2
--- /dev/null
+++ b/validation/c23-nullptr-error.c
@@ -0,0 +1,107 @@
+typedef typeof(nullptr) nullptr_t;
+
+static int (nullptr);
+
+enum bad_enum {
+	E_BAD =3D nullptr,
+	E_NEXT,
+};
+
+struct bad_bf {
+	unsigned int x : nullptr;
+};
+
+static int bad_arr[nullptr];
+
+static void test_errors(int *p, int c)
+{
+	nullptr_t np =3D nullptr;
+	int i2 =3D (int)nullptr;
+	long l2 =3D (long)np;
+	double d2 =3D (double)nullptr;
+	nullptr_t b1 =3D (nullptr_t)1;
+	nullptr_t b2 =3D (nullptr_t)(int *)0;
+	bool r1 =3D nullptr < nullptr;
+	bool r2 =3D np > p;
+	bool r3 =3D nullptr =3D=3D 1;
+	int t1 =3D c ? nullptr : 1;
+	nullptr_t t0 =3D c ? nullptr : 0;
+	void *a1 =3D nullptr + 1;
+	int u1 =3D *nullptr;
+	int u2 =3D +nullptr;
+	int u3 =3D -nullptr;
+	int u4 =3D ~nullptr;
+	np++;
+
+	switch (np) {
+	default:
+		break;
+	}
+
+	switch (c) {
+	case nullptr:
+		break;
+	}
+
+	(void)i2;
+	(void)l2;
+	(void)d2;
+	(void)b1;
+	(void)b2;
+	(void)r1;
+	(void)r2;
+	(void)r3;
+	(void)t1;
+	(void)t0;
+	(void)a1;
+	(void)u1;
+	(void)u2;
+	(void)u3;
+	(void)u4;
+}
+
+/*
+ * check-name: c23-nullptr-error
+ * check-command: sparse -std=3Dc23 -Wno-decl $file
+ *
+ * check-error-start
+c23-nullptr-error.c:3:12: error: Trying to use reserved word 'nullptr' a=
s identifier
+c23-nullptr-error.c:6:17: error: enumerator value for 'E_BAD' is not an =
integer constant
+c23-nullptr-error.c:11:26: error: bad integer constant expression
+c23-nullptr-error.c:11:33: error: bitfield 'x' has invalid width (0)
+c23-nullptr-error.c:14:20: error: size of array has non-integer type
+c23-nullptr-error.c:19:19: error: conversion from 'nullptr_t' to 'int'
+c23-nullptr-error.c:20:20: error: conversion from 'nullptr_t' to 'long'
+c23-nullptr-error.c:21:22: error: conversion from 'nullptr_t' to 'double=
'
+c23-nullptr-error.c:22:25: error: conversion from 'int' to 'nullptr_t'
+c23-nullptr-error.c:23:25: error: conversion from 'int *' to 'nullptr_t'
+c23-nullptr-error.c:24:27: error: incompatible types for operation (<):
+c23-nullptr-error.c:24:27:    nullptr_t
+c23-nullptr-error.c:24:27:    nullptr_t
+c23-nullptr-error.c:25:22: error: incompatible types for operation (>):
+c23-nullptr-error.c:25:22:    nullptr_t [usertype] np
+c23-nullptr-error.c:25:22:    int *p
+c23-nullptr-error.c:26:27: error: incompatible types for operation (=3D=3D=
):
+c23-nullptr-error.c:26:27:    nullptr_t
+c23-nullptr-error.c:26:27:    int
+c23-nullptr-error.c:27:20: error: incompatible types in conditional expr=
ession (different types):
+c23-nullptr-error.c:27:20:    nullptr_t
+c23-nullptr-error.c:27:20:    int
+c23-nullptr-error.c:28:26: error: incompatible types in conditional expr=
ession (different types):
+c23-nullptr-error.c:28:26:    nullptr_t
+c23-nullptr-error.c:28:26:    int
+c23-nullptr-error.c:29:28: error: incompatible types for operation (+):
+c23-nullptr-error.c:29:28:    nullptr_t
+c23-nullptr-error.c:29:28:    int
+c23-nullptr-error.c:30:18: error: cannot dereference this type
+c23-nullptr-error.c:31:18: error: incompatible type for operation (+):
+c23-nullptr-error.c:31:18:    nullptr_t
+c23-nullptr-error.c:32:18: error: incompatible type for operation (-):
+c23-nullptr-error.c:32:18:    nullptr_t
+c23-nullptr-error.c:33:18: error: incompatible type for operation (~):
+c23-nullptr-error.c:33:18:    nullptr_t
+c23-nullptr-error.c:34:11: error: need scalar for ++/--
+c23-nullptr-error.c:36:17: error: switch quantity is not an integer
+c23-nullptr-error.c:42:14: error: incompatible types for 'case' statemen=
t
+ * check-error-end
+ */
diff --git a/validation/c23-nullptr.c b/validation/c23-nullptr.c
new file mode 100644
index 000000000000..e7c0d4aa7f45
--- /dev/null
+++ b/validation/c23-nullptr.c
@@ -0,0 +1,107 @@
+typedef typeof(nullptr) nullptr_t;
+
+static_assert(sizeof(nullptr) =3D=3D sizeof(void *), "sizeof nullptr");
+static_assert(sizeof(nullptr_t) =3D=3D sizeof(void *), "sizeof nullptr_t=
");
+static_assert(alignof(nullptr_t) =3D=3D alignof(void *), "alignof nullpt=
r_t");
+static_assert(_Generic(nullptr, nullptr_t: 1, void *: 0, int: 0, default=
: 0) =3D=3D 1,
+	      "typeof nullptr is nullptr_t");
+
+void *p =3D nullptr;
+int *q =3D nullptr;
+nullptr_t np =3D nullptr;
+static nullptr_t np_zero =3D 0;
+static nullptr_t np_void0 =3D (void *)0;
+static void (*fp_global)(void) =3D nullptr;
+
+static void test_call(int *arg1, nullptr_t arg2)
+{
+	(void)arg1;
+	(void)arg2;
+}
+
+static void test_varargs(int n, ...)
+{
+	(void)n;
+}
+
+static nullptr_t test_ret_np(void)
+{
+	return nullptr;
+}
+
+static int *test_ret_ptr(void)
+{
+	return nullptr;
+}
+
+static void dummy_fn(void)
+{
+}
+
+static void test_func(const int *cq_const)
+{
+	p =3D np;
+	q =3D np;
+	np =3D 0;
+	np =3D (void *)0;
+	np =3D (nullptr_t)nullptr;
+	np =3D (const nullptr_t)np;
+	np =3D test_ret_np();
+	q =3D test_ret_ptr();
+
+	void (*fp)(void) =3D np;
+	fp =3D nullptr;
+	if (fp =3D=3D nullptr || nullptr !=3D dummy_fn) {
+	}
+
+	test_call(nullptr, nullptr);
+	test_call(np, np);
+	test_call(np_zero, np_void0);
+	test_varargs(2, nullptr, np);
+
+	(void)nullptr;
+	(void)np;
+	(void)fp_global;
+
+	bool b1 =3D nullptr;
+	bool b2 =3D np;
+	bool b3 =3D (bool)nullptr;
+	bool b4 =3D (bool)np;
+	(void)b1;
+	(void)b2;
+	(void)b3;
+	(void)b4;
+
+	if (nullptr) {
+	}
+	if (!nullptr && !np) {
+	}
+	if (p =3D=3D nullptr && nullptr =3D=3D q) {
+	}
+	if (np =3D=3D p && p =3D=3D np) {
+	}
+	if (np =3D=3D nullptr && np =3D=3D 0 && 0 =3D=3D np && np =3D=3D (void =
*)0) {
+	}
+
+	int cond =3D 1;
+	void *cp =3D cond ? nullptr : p;
+	int *cq =3D cond ? q : nullptr;
+	const int *ccq =3D cond ? np : cq_const;
+	void *cv0 =3D cond ? nullptr : (void *)0;
+	nullptr_t cnp1 =3D cond ? np : nullptr;
+
+	static_assert(_Generic(1 ? nullptr : (int *)0, int *: 1, default: 0) =3D=
=3D 1);
+	static_assert(_Generic(1 ? nullptr : (void *)0, void *: 1, default: 0) =
=3D=3D 1);
+	static_assert(_Generic(1 ? np : nullptr, nullptr_t: 1, default: 0) =3D=3D=
 1);
+
+	(void)cp;
+	(void)cq;
+	(void)ccq;
+	(void)cv0;
+	(void)cnp1;
+}
+
+/*
+ * check-name: c23-nullptr
+ * check-command: sparse -std=3Dc23 -pedantic -Wno-decl -Wno-non-pointer=
-null $file
+ */
diff --git a/validation/linear/c23-nullptr.c b/validation/linear/c23-null=
ptr.c
new file mode 100644
index 000000000000..bdf4fb36e32a
--- /dev/null
+++ b/validation/linear/c23-nullptr.c
@@ -0,0 +1,20 @@
+typedef typeof(nullptr) nullptr_t;
+
+static void *np_to_ptr(nullptr_t np)
+{
+	return np;
+}
+
+static bool np_is_null(nullptr_t np)
+{
+	return !np;
+}
+
+/*
+ * check-name: linear-c23-nullptr
+ * check-command: test-linearize -m64 -std=3Dc23 $file
+ *
+ * check-output-ignore
+ * check-output-contains: ret\\.64 *%arg1
+ * check-output-contains: seteq\\.1
+ */

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256441;
	b=GpvK98IcYQ2r8ObbKmS/NvtVno6oQufdFer/E9nbXStH9lHd6ZlXPhUFXnvXczXt8GjB
	 bK1+SiRgJFp0KsSw2+0WUnwQ23QK8whQ8HYiq27wVFVQSv9EyUZ3WL30jXwJz89J/soB8
	 IbRpRqNbCdPHEluQc/y1FHFJwqnTN4Nvdl4f8vUEiEYF0jW2Mvqv9mvWFHO8cYByoyQZc
	 wtIngOzPvGGBLiT15ZrH2mxVaglk8bmRRR5FgEqpULL/2ziLcpw5RBJP8iJImtbuUvoIw
	 LMvUa0P5LIH/siwG7fhEdRa6tS/w9qlW2DzOSHzgsDHM1TNgJMY+zXouXHvdkkM3bRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=idf/x8dRr1Vybr19KwNf1t1vD6xE/+Pvcd4He8//Yz4=;
	b=NXMK+quQ4I9F56ya2vVmT+KHmmcPTA1KaCzTZvKqypMfS2FG+/svDh4j8813nBQqNQPE
	 OMl1RpPenURKAnXIBlL7Up7QzTkBw4Ur8Isf7JKhwHqR8A6flHq1x6Teh5d+nxru4xM6R
	 K3jZhaPaYGPHjmjE12Q8IuqvyNZtkNJiOalEybarONTmJRViMqa1O9YExjzvR9KVCqW9Y
	 sCS5jSg6m8OTdSF843M0pEPgBuys2mqcu7BZXnKUh6pf3DOnJjri9H7p58GHO89ZeaDpG
	 6ZGmfL1B+7VTtgCD3+XZ1EPG6RKNjU25AZ14HHtS18WdGLNRjRxD1rXSZ0U33Z6dsHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=xeKGhZrc;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814F2606A335
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 814F2606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=xeKGhZrc
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhMQ3TzJz1XM6JF;
	Mon,  9 Nov 2026 20:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256416; x=1796848417; bh=idf/x
	8dRr1Vybr19KwNf1t1vD6xE/+Pvcd4He8//Yz4=; b=xeKGhZrcXqTF7mvhd7oIk
	L9so4A/6NvNSVe4ICjfF5Ze8Ysd8+fpRus8UTn2fR3SRiGuzOoiAUX/RixPzAEDK
	b9R64vZfmc7jd+SeCX1LlO0jgmtQA+KKGVqbrC50ikUcefGjeFBqRb8URcrVztup
	kM0MHkrU34nYPWwjzWsIAFmcPYSDnFHNhrXQ5SRd0ZgdxJ23obesD7qT54GtwZhJ
	FqNM/MbnDvguOftjOBVq2xYXKJcL2Hq+uI7a8nWq2bnu0tQbVcLLFYgiQ+Lau0hq
	eUbhSTt+XRjEnyrwVn4768WOCY1B6H4hhKEvCDzOjm9EdY8JCLpsvx14CCgMfyDX
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id CDhXweFs7nyd; Mon,  9 Nov 2026 20:33:36 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM331h5z1XM4Tn;
	Mon,  9 Nov 2026 20:33:35 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 50/73] c23: Support constexpr object specifier
Date: Mon,  9 Nov 2026 12:32:36 -0800
Message-ID: <20261109203259.362845-51-bvanassche@acm.org>
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

Add support for the ISO C23 'constexpr' object specifier and enforce its
linkage, qualification, and constant-initializer rules:
- Apply 'const' qualification after declarator parsing (cloning array
  chains) so pointers become top-level const ('int *const') and array
  elements become const without mutating shared array typedefs.
- Include MOD_CONSTEXPR in MOD_IGNORE for _Generic selection and give
  file-scope constexpr objects internal linkage per C23 6.2.2p3.
- Allow block-scope 'constexpr register' and 'constexpr auto', while
  rejecting constexpr on functions, parameters, struct/union members,
  empty declarations, typedefs, extern, thread_local, file-scope
  register, VLAs, and volatile, _Atomic, or restrict types.
- Mark constexpr symbols underspecified during initializer evaluation and
  validate scalar and aggregate initializers for null pointers, integer
  constant expressions, and exact target representability.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 evaluate.c                           | 261 ++++++++++++++++++++++++++-
 expand.c                             |  90 +++++++--
 expand.h                             |   3 +
 ident-list.h                         |   1 +
 parse.c                              | 108 ++++++++++-
 show-parse.c                         |  51 +++---
 symbol.c                             |   6 +-
 symbol.h                             |  17 +-
 validation/c23-constexpr-error.c     |  92 ++++++++++
 validation/c23-constexpr-self-init.c |  41 +++++
 validation/c23-constexpr.c           | 100 ++++++++++
 11 files changed, 706 insertions(+), 64 deletions(-)
 create mode 100644 validation/c23-constexpr-error.c
 create mode 100644 validation/c23-constexpr-self-init.c
 create mode 100644 validation/c23-constexpr.c

diff --git a/evaluate.c b/evaluate.c
index 1b1a72577d18..b7e352f55e6c 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -35,6 +35,7 @@
 #include <limits.h>
=20
 #include "evaluate.h"
+#include "expand.h"
 #include "simplify.h"
 #include "lib.h"
 #include "allocate.h"
@@ -95,6 +96,8 @@ static struct symbol *evaluate_symbol_expression(struct=
 expression *expr)
 	}
=20
 	examine_symbol_type(sym);
+	if (sym->ctype.modifiers & MOD_CONSTEXPR)
+		evaluate_symbol(sym);
=20
 	base_type =3D get_base_type(sym);
 	if (!base_type) {
@@ -111,6 +114,14 @@ static struct symbol *evaluate_symbol_expression(str=
uct expression *expr)
 	expr->op =3D '*';
 	expr->unop =3D addr;
 	expr->flags =3D CEF_NONE;
+	if (sym->ctype.modifiers & MOD_CONSTEXPR) {
+		if (is_float_type(base_type))
+			expr->flags =3D CEF_SET_FLOAT;
+		else if (is_int_type(base_type))
+			expr->flags =3D CEF_SET_ICE;
+		else
+			expr->flags =3D CEF_ADDR;
+	}
=20
 	/* The type of a symbol is the symbol itself! */
 	expr->ctype =3D sym;
@@ -2388,6 +2399,14 @@ static struct symbol *evaluate_member_dereference(=
struct expression *expr)
 	expr->type =3D EXPR_PREOP;
 	expr->op =3D '*';
 	expr->unop =3D add;
+	if (mod & MOD_CONSTEXPR) {
+		if (is_float_type(ctype))
+			expr->flags =3D CEF_SET_FLOAT;
+		else if (is_int_type(ctype))
+			expr->flags =3D CEF_SET_ICE;
+		else
+			expr->flags =3D CEF_ADDR;
+	}
=20
 	expr->ctype =3D member;
 	return member;
@@ -2922,7 +2941,7 @@ found:
 		else
 			v =3D &top->ident_expression;
=20
-		mods |=3D ctype->ctype.modifiers & MOD_STORAGE;
+		mods |=3D ctype->ctype.modifiers & (MOD_STORAGE | MOD_CONSTEXPR);
 		if (handle_initializer(v, 1, lclass, top->ctype, mods))
 			continue;
=20
@@ -3015,6 +3034,161 @@ static struct expression *handle_scalar(struct ex=
pression *e, int nested)
  * { "string", ...} - we need to preserve that string literal recognizab=
le
  * until we dig into the inner struct.
  */
+static void check_constexpr_scalar_init(struct expression *orig,
+					struct symbol *target)
+{
+	struct symbol *ttype, *stype;
+	int tclass =3D classify_type(target, &ttype);
+	int sclass =3D classify_type(orig->ctype, &stype);
+	struct expression tmp;
+
+	if (!valid_type(target) || !valid_type(orig->ctype))
+		return;
+
+	if ((tclass & TYPE_PTR) || is_nullptr_type(ttype)) {
+		if (!(orig->flags & (CEF_ACE | CEF_ADDR))) {
+			sparse_error(orig->pos,
+				     "non-constant initializer for constexpr object");
+			return;
+		}
+		tmp =3D *orig;
+		if (!is_null_pointer_constant(&tmp) &&
+		    !(((sclass & TYPE_PTR) || is_nullptr_type(stype)) && is_zero_const=
ant(&tmp)))
+			sparse_error(orig->pos,
+				     "constexpr pointer initializer is not null");
+		return;
+	}
+
+	if (is_int(tclass)) {
+		int sw, tw;
+		bool s_unsigned, t_unsigned, s_neg;
+
+		if (!(orig->flags & (CEF_ACE | CEF_ADDR))) {
+			sparse_error(orig->pos,
+				     "non-constant initializer for constexpr object");
+			return;
+		}
+		if (!(orig->flags & CEF_ICE) || !is_int(sclass)) {
+			sparse_error(
+				orig->pos,
+				"constexpr integer initializer is not an integer constant expression=
");
+			return;
+		}
+		tmp =3D *orig;
+		expand_constexpr_initializer(&tmp);
+		if (tmp.type !=3D EXPR_VALUE) {
+			sparse_error(orig->pos,
+				     "non-constant initializer for constexpr object");
+			return;
+		}
+		sw =3D stype->bit_size;
+		s_unsigned =3D (stype->ctype.modifiers & MOD_UNSIGNED) !=3D 0;
+		s_neg =3D !s_unsigned && sw > 0 && sw <=3D 64 &&
+			(tmp.value & sign_bit(sw)) !=3D 0;
+		if (is_bool_type(ttype)) {
+			if (s_neg || (tmp.value !=3D 0 && tmp.value !=3D 1))
+				sparse_error(
+					orig->pos,
+					"constexpr initializer not representable in target type");
+			return;
+		}
+		tw =3D ttype->bit_size;
+		t_unsigned =3D (ttype->ctype.modifiers & MOD_UNSIGNED) !=3D 0;
+		if (s_neg) {
+			long long sval =3D sw > 64 ? (long long)tmp.value :
+						   bits_extend(tmp.value, sw, 1);
+			if (t_unsigned ||
+			    (tw < 64 && sval < -(1LL << (tw - 1))))
+				sparse_error(
+					orig->pos,
+					"constexpr initializer not representable in target type");
+		} else {
+			unsigned long long uval =3D
+				sw > 64 ? tmp.value :
+					  (unsigned long long)zero_extend(tmp.value, sw);
+			int max_bits =3D t_unsigned ? tw : (tw - 1);
+			if ((max_bits <=3D 0 && uval !=3D 0) ||
+			    (max_bits > 0 && max_bits < 64 &&
+			     (uval >> max_bits) !=3D 0))
+				sparse_error(
+					orig->pos,
+					"constexpr initializer not representable in target type");
+		}
+		return;
+	}
+
+	if (tclass & TYPE_FLOAT) {
+		if (!(orig->flags & CEF_ACE) || !(sclass & TYPE_NUM)) {
+			sparse_error(orig->pos,
+				     "non-constant initializer for constexpr object");
+			return;
+		}
+		tmp =3D *orig;
+		expand_constexpr_initializer(&tmp);
+		if (sclass & TYPE_FLOAT) {
+			long double fv;
+			if (tmp.type !=3D EXPR_FVALUE) {
+				sparse_error(
+					orig->pos,
+					"non-constant initializer for constexpr object");
+				return;
+			}
+			fv =3D tmp.fvalue;
+			if (stype->rank > ttype->rank && fv =3D=3D fv) {
+				bool ok =3D ttype->rank < 0 ?
+						  ((long double)(float)fv =3D=3D fv) :
+						  (ttype->rank =3D=3D 0 ?
+							   ((long double)(double)fv =3D=3D fv) :
+							   true);
+				if (!ok)
+					sparse_error(
+						orig->pos,
+						"constexpr initializer not representable in target type");
+			}
+		} else if (is_int(sclass)) {
+			int sw =3D stype->bit_size;
+			bool s_unsigned =3D (stype->ctype.modifiers & MOD_UNSIGNED) !=3D 0;
+			bool s_neg =3D !s_unsigned && sw > 0 && sw <=3D 64 &&
+				     (tmp.value & sign_bit(sw)) !=3D 0;
+			if (tmp.type !=3D EXPR_VALUE) {
+				sparse_error(
+					orig->pos,
+					"non-constant initializer for constexpr object");
+				return;
+			}
+			if (s_neg) {
+				long long sval =3D sw > 64 ? (long long)tmp.value :
+							   bits_extend(tmp.value, sw, 1);
+				long double ld =3D ttype->rank < 0 ?
+							 (long double)(float)sval :
+							 (ttype->rank =3D=3D 0 ?
+								  (long double)(double)sval :
+								  (long double)sval);
+				if (sval !=3D LLONG_MIN &&
+				    (ld <=3D (long double)LLONG_MIN ||
+				     (long long)ld !=3D sval))
+					sparse_error(
+						orig->pos,
+						"constexpr initializer not representable in target type");
+			} else {
+				unsigned long long uval =3D
+					sw > 64 ? tmp.value :
+						  (unsigned long long)zero_extend(tmp.value, sw);
+				long double ld =3D ttype->rank < 0 ?
+							 (long double)(float)uval :
+							 (ttype->rank =3D=3D 0 ?
+								  (long double)(double)uval :
+								  (long double)uval);
+				if (ld >=3D 18446744073709551616.0L ||
+				    (unsigned long long)ld !=3D uval)
+					sparse_error(
+						orig->pos,
+						"constexpr initializer not representable in target type");
+			}
+		}
+	}
+}
+
 static int handle_initializer(struct expression **ep, int nested,
 		int class, struct symbol *ctype, unsigned long mods)
 {
@@ -3026,20 +3200,27 @@ static int handle_initializer(struct expression *=
*ep, int nested,
=20
 	/* scalar */
 	if (!(class & TYPE_COMPOUND)) {
+		struct expression orig;
+
 		e =3D handle_scalar(e, nested);
+
 		if (!e)
 			return 0;
 		*ep =3D e;
 		if (!evaluate_expression(e))
 			return 1;
+		degenerate(e);
+		orig =3D *e;
 		compatible_assignment_types(e, ctype, ep, "initializer");
 		/*
 		 * Initializers for static storage duration objects
 		 * shall be constant expressions or a string literal [6.7.8(4)].
 		 */
 		mods |=3D ctype->ctype.modifiers;
-		mods &=3D (MOD_TOPLEVEL | MOD_STATIC);
-		if (mods && !(e->flags & (CEF_ACE | CEF_ADDR)))
+		if (mods & MOD_CONSTEXPR)
+			check_constexpr_scalar_init(&orig, ctype);
+		if ((mods & (MOD_TOPLEVEL | MOD_STATIC)) &&
+		    !(e->flags & (CEF_ACE | CEF_ADDR)))
 			if (Wconstexpr_not_const)
 				warning(e->pos, "non-constant initializer for static object");
=20
@@ -3084,12 +3265,18 @@ static int handle_initializer(struct expression *=
*ep, int nested,
 	type =3D evaluate_expression(e);
 	if (!type)
 		return 0;
+	mods |=3D ctype->ctype.modifiers;
 	if (ctype->type =3D=3D SYM_NODE)
 		ctype =3D ctype->ctype.base_type;
 	if (type->type =3D=3D SYM_NODE)
 		type =3D type->ctype.base_type;
-	if (ctype =3D=3D type)
+	if (ctype =3D=3D type) {
+		if ((mods & MOD_CONSTEXPR) && !(e->flags & (CEF_ACE | CEF_ADDR)))
+			sparse_error(
+				e->pos,
+				"non-constant initializer for constexpr object");
 		return 1;
+	}
 	return 0;
=20
 String:
@@ -3843,6 +4030,55 @@ void check_duplicates(struct symbol *sym)
 	}
 }
=20
+static bool check_constexpr_vm_type(struct symbol *type)
+{
+	while (type) {
+		examine_symbol_type(type);
+		switch (type->type) {
+		case SYM_NODE:
+		case SYM_PTR:
+			type =3D type->ctype.base_type;
+			continue;
+		case SYM_ARRAY:
+			if (type->array_size &&
+			    type->array_size->type !=3D EXPR_VALUE)
+				return true;
+			type =3D type->ctype.base_type;
+			continue;
+		default:
+			return false;
+		}
+	}
+	return false;
+}
+
+static bool has_invalid_constexpr_qualifiers(struct symbol *type)
+{
+	while (type) {
+		if (type->ctype.modifiers &
+		    (MOD_VOLATILE | MOD_ATOMIC | MOD_RESTRICT))
+			return true;
+		switch (type->type) {
+		case SYM_NODE:
+		case SYM_ARRAY:
+			type =3D type->ctype.base_type;
+			continue;
+		case SYM_STRUCT:
+		case SYM_UNION: {
+			struct symbol *m;
+			FOR_EACH_PTR(type->symbol_list, m) {
+				if (has_invalid_constexpr_qualifiers(m))
+					return true;
+			} END_FOR_EACH_PTR(m);
+			return false;
+		}
+		default:
+			return false;
+		}
+	}
+	return false;
+}
+
 static struct symbol *evaluate_symbol(struct symbol *sym)
 {
 	struct symbol *base_type;
@@ -3858,9 +4094,24 @@ static struct symbol *evaluate_symbol(struct symbo=
l *sym)
 	if (!base_type)
 		return NULL;
=20
+	if ((sym->ctype.modifiers & MOD_CONSTEXPR) &&
+	    base_type->type !=3D SYM_FN && !(sym->ctype.modifiers & MOD_USERTYP=
E)) {
+		if (check_constexpr_vm_type(sym))
+			sparse_error(
+				sym->pos,
+				"constexpr variable '%s' cannot have variably modified type",
+				show_ident(sym->ident));
+		if (has_invalid_constexpr_qualifiers(sym))
+			sparse_error(
+				sym->pos,
+				"constexpr variable '%s' cannot have volatile, atomic, or restrict t=
ype",
+				show_ident(sym->ident));
+	}
+
 	/* Evaluate the initializers */
 	if (sym->initializer) {
-		bool mark_underspec =3D sym->c23_auto;
+		bool mark_underspec =3D sym->c23_auto ||
+				      (sym->ctype.modifiers & MOD_CONSTEXPR);
 		if (mark_underspec)
 			sym->underspecified =3D 1;
 		evaluate_initializer(sym, &sym->initializer);
diff --git a/expand.c b/expand.c
index 267aaf00e9ce..73b37b93534e 100644
--- a/expand.c
+++ b/expand.c
@@ -710,6 +710,41 @@ redo:
 	return &value;
 }
=20
+static struct expression *lookup_initializer_offset(struct expression *v=
alue, unsigned int offset, bool recurse)
+{
+	struct expression *entry;
+
+	FOR_EACH_PTR(value->expr_list, entry) {
+		if (entry->type =3D=3D EXPR_INITIALIZER && recurse) {
+			struct expression *sub =3D lookup_initializer_offset(entry, offset, r=
ecurse);
+			if (sub)
+				return sub;
+			continue;
+		}
+		if (entry->type !=3D EXPR_POS) {
+			if (offset)
+				continue;
+			return entry;
+		}
+		if (entry->init_nr > 1 && entry->ctype) {
+			int elem_bytes =3D bits_to_bytes(entry->ctype->bit_size);
+			if (elem_bytes > 0) {
+				unsigned long long end =3D (unsigned long long)entry->init_offset +
+							 (unsigned long long)entry->init_nr * elem_bytes;
+				if (offset >=3D entry->init_offset && offset < end &&
+				    ((offset - entry->init_offset) % elem_bytes) =3D=3D 0)
+					return entry->init_expr;
+			}
+		}
+		if (entry->init_offset < offset)
+			continue;
+		if (entry->init_offset > offset)
+			break;
+		return entry->init_expr;
+	} END_FOR_EACH_PTR(entry);
+	return NULL;
+}
+
 /*
  * Look up a trustable initializer value at the requested offset.
  *
@@ -719,35 +754,36 @@ static struct expression *constant_symbol_value(str=
uct symbol *sym, int offset)
 {
 	struct expression *value;
=20
-	if (offset < 0)
+	if (offset < 0 || sym->expanding)
 		return NULL;
 	if (sym->ctype.modifiers & MOD_VOLATILE)
 		return NULL;
-	if (sym->ctype.modifiers & MOD_ACCESS)
+	if ((sym->ctype.modifiers & MOD_ACCESS) &&
+	    !(sym->ctype.modifiers & MOD_CONSTEXPR))
 		return NULL;
 	if ((sym->ctype.modifiers & (MOD_TOPLEVEL | MOD_STATIC)) &&
-	    !(sym->ctype.modifiers & MOD_CONST) &&
+	    !(sym->ctype.modifiers & (MOD_CONST | MOD_CONSTEXPR)) &&
 	    !sym->string && sym->ident)
 		return NULL;
 	value =3D sym->initializer;
 	if (!value)
 		return NULL;
+	sym->expanding =3D 1;
+	expand_expression(value);
+	sym->expanding =3D 0;
+	if (value->type =3D=3D EXPR_PREOP && value->op =3D=3D '*' &&
+	    value->unop && value->unop->type =3D=3D EXPR_SYMBOL &&
+	    (value->unop->symbol->ctype.modifiers & MOD_CONSTEXPR)) {
+		sym->expanding =3D 1;
+		value =3D constant_symbol_value(value->unop->symbol, offset);
+		sym->expanding =3D 0;
+		return value;
+	}
 	if (value->type =3D=3D EXPR_INITIALIZER) {
-		struct expression *entry;
-		FOR_EACH_PTR(value->expr_list, entry) {
-			if (entry->type !=3D EXPR_POS) {
-				if (offset)
-					continue;
-				return entry;
-			}
-			if (entry->init_offset < offset)
-				continue;
-			if (entry->init_offset > offset)
-				break;
-			return entry->init_expr;
-		} END_FOR_EACH_PTR(entry);
-
-		value =3D default_initializer(sym, offset);
+		bool recurse =3D (sym->ctype.modifiers & (MOD_CONST | MOD_CONSTEXPR)) =
!=3D 0;
+		value =3D lookup_initializer_offset(value, offset, recurse);
+		if (!value)
+			value =3D default_initializer(sym, offset);
 	}
 	return value;
 }
@@ -801,12 +837,17 @@ static int expand_dereference(struct expression *ex=
pr)
 				expr->type =3D EXPR_VALUE;
 				expr->value =3D value->value;
 				expr->taint =3D 0;
+				if ((sym->ctype.modifiers & MOD_CONSTEXPR) &&
+				    is_int_type(ctype))
+					expr->flags =3D CEF_SET_ICE;
 				return 0;
 			} else if (value->type =3D=3D EXPR_FVALUE) {
 				if (!is_float_type(ctype))
 					return UNSAFE;
 				expr->type =3D EXPR_FVALUE;
 				expr->fvalue =3D value->fvalue;
+				if (sym->ctype.modifiers & MOD_CONSTEXPR)
+					expr->flags =3D CEF_SET_FLOAT;
 				return 0;
 			}
 		}
@@ -1086,6 +1127,11 @@ static unsigned long bit_offset(const struct expre=
ssion *expr)
 		offset +=3D bytes_to_bits(expr->init_offset);
 		expr =3D expr->init_expr;
 	}
+	if (expr && expr->type =3D=3D EXPR_INITIALIZER) {
+		struct expression *first =3D first_ptr_list((struct ptr_list *)expr->e=
xpr_list);
+		if (first)
+			return offset + bit_offset(first);
+	}
 	if (expr && expr->ctype)
 		offset +=3D expr->ctype->bit_offset;
 	return offset;
@@ -1537,3 +1583,11 @@ int is_zero_constant(struct expression *expr)
 	conservative =3D saved;
 	return expr->type =3D=3D EXPR_VALUE && !expr->value;
 }
+
+void expand_constexpr_initializer(struct expression *expr)
+{
+	const int saved =3D conservative;
+	conservative =3D 1;
+	expand_expression(expr);
+	conservative =3D saved;
+}
diff --git a/expand.h b/expand.h
index 27e10c0a87e3..44b300b2a36e 100644
--- a/expand.h
+++ b/expand.h
@@ -31,4 +31,7 @@
 #define SELECT_COST 20		/* Cut-off for turning a conditional into a sele=
ct */
 #define BRANCH_COST 10		/* Cost of a conditional branch */
=20
+struct expression;
+void expand_constexpr_initializer(struct expression *expr);
+
 #endif
diff --git a/ident-list.h b/ident-list.h
index 18dabf5193b2..46e6cd9e4f61 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -47,6 +47,7 @@ IDENT(_Thread_local);
 IDENT(alignas);
 IDENT(alignof);
 IDENT(bool);
+IDENT(constexpr);
 IDENT(false);
 IDENT(nullptr);
 IDENT(static_assert);
diff --git a/parse.c b/parse.c
index 324da8e40423..a7d31fad1a10 100644
--- a/parse.c
+++ b/parse.c
@@ -57,7 +57,7 @@ static declarator_t
 	attribute_specifier, typeof_specifier, typeof_unqual_specifier,
 	storage_specifier, thread_specifier;
 static declarator_t generic_qualifier;
-static declarator_t autotype_specifier, auto_specifier;
+static declarator_t autotype_specifier, auto_specifier, constexpr_specif=
ier;
=20
 static struct token *parse_if_statement(struct token *token, struct stat=
ement *stmt);
 static struct token *parse_return_statement(struct token *token, struct =
statement *stmt);
@@ -146,6 +146,11 @@ static struct symbol_op auto_op =3D {
 	.declarator =3D auto_specifier,
 };
=20
+static struct symbol_op constexpr_op =3D {
+	.type =3D KW_MODIFIER,
+	.declarator =3D constexpr_specifier,
+};
+
 static struct symbol_op register_op =3D {
 	.type =3D KW_MODIFIER,
 	.declarator =3D storage_specifier,
@@ -479,6 +484,7 @@ static struct init_keyword {
 	N("__thread",		&thread_op),
 	N("_Thread_local",	&thread_op),
 	N("thread_local",	&thread_op,	.std =3D STANDARD_C23),
+	N("constexpr",		&constexpr_op,	.std =3D STANDARD_C23),
=20
 	A("inline",		&inline_op,	.mods =3D MOD_INLINE),
=20
@@ -1211,6 +1217,37 @@ static struct token *auto_specifier(struct token *=
token, struct symbol *sym,
 	return token;
 }
=20
+static struct token *constexpr_specifier(struct token *token,
+					 struct symbol *sym,
+					 struct decl_state *ctx)
+{
+	if (ctx->is_constexpr)
+		sparse_error(token->pos, "duplicate constexpr");
+	ctx->is_constexpr =3D 1;
+	ctx->ctype.modifiers |=3D MOD_CONSTEXPR;
+	return token;
+}
+
+static void apply_constexpr_const(struct symbol *sym)
+{
+	struct ctype *ctype;
+
+	if (!sym)
+		return;
+	sym->ctype.modifiers |=3D MOD_CONST;
+	ctype =3D &sym->ctype;
+	while (ctype->base_type) {
+		struct symbol *base =3D ctype->base_type;
+		if (base->type !=3D SYM_NODE && base->type !=3D SYM_ARRAY)
+			break;
+		struct symbol *copy =3D alloc_symbol(base->pos, base->type);
+		*copy =3D *base;
+		copy->ctype.modifiers |=3D MOD_CONST;
+		ctype->base_type =3D copy;
+		ctype =3D &copy->ctype;
+	}
+}
+
 static struct token *ignore_attribute(struct token *token, struct symbol=
 *attr, struct decl_state *ctx)
 {
 	struct expression *expr =3D NULL;
@@ -2119,6 +2156,11 @@ static struct token *declaration_list(struct token=
 *token, struct symbol_list **
 			if (ctx.autotype)
 				decl->ctype.base_type =3D &bad_ctype;
 		}
+		if (ctx.is_constexpr)
+			sparse_error(
+				decl->pos,
+				"struct or union member '%s' cannot be declared constexpr",
+				show_ident(decl->ident));
 		if (decl->ctype.modifiers & MOD_TLS)
 			sparse_error(
 				decl->pos,
@@ -2166,10 +2208,6 @@ static struct token *parameter_declaration(struct =
token *token, struct symbol *s
 	sym->ctype.modifiers |=3D decl_modifiers(&ctx);
 	sym->endpos =3D token->pos;
 	sym->forced_arg =3D ctx.forced;
-	if (ctx.has_alignas)
-		sparse_error(sym->pos,
-			     "alignment specified for parameter '%s'",
-			     show_ident(sym->ident));
 	if (ctx.has_auto || ctx.autotype) {
 		sparse_error(sym->pos,
 			     "parameter '%s' cannot be declared %s",
@@ -2178,6 +2216,14 @@ static struct token *parameter_declaration(struct =
token *token, struct symbol *s
 		if (ctx.autotype)
 			sym->ctype.base_type =3D &bad_ctype;
 	}
+	if (ctx.is_constexpr)
+		sparse_error(sym->pos,
+			     "parameter '%s' cannot be declared constexpr",
+			     show_ident(sym->ident));
+	if (ctx.has_alignas)
+		sparse_error(sym->pos,
+			     "alignment specified for parameter '%s'",
+			     show_ident(sym->ident));
 	if (sym->ctype.modifiers & MOD_TLS)
 		sparse_error(sym->pos,
 			     "parameter '%s' cannot be thread-local",
@@ -2203,6 +2249,8 @@ struct token *typename(struct token *token, struct =
symbol **p, int *forced)
 	apply_modifiers(token->pos, &ctx);
 	sym->ctype =3D ctx.ctype;
 	sym->endpos =3D token->pos;
+	if (ctx.is_constexpr)
+		sparse_error(sym->pos, "constexpr in typename");
 	class =3D ctx.storage_class;
 	if (forced)
 		*forced =3D ctx.forced;
@@ -3264,6 +3312,9 @@ struct token *external_declaration(struct token *to=
ken, struct symbol_list **lis
 		if (ctx.autotype)
 			sparse_error(token->pos, "%s in empty declaration",
 				     ctx.has_auto ? "auto" : "__auto_type");
+		if (ctx.is_constexpr)
+			sparse_error(token->pos,
+				     "constexpr in empty declaration");
 		apply_modifiers(token->pos, &ctx);
 		return token->next;
 	}
@@ -3294,6 +3345,10 @@ struct token *external_declaration(struct token *t=
oken, struct symbol_list **lis
 		decl->ctype.modifiers |=3D MOD_USERTYPE;
=20
 	base_type =3D decl->ctype.base_type;
+	if (ctx.is_constexpr && !is_typedef &&
+	    (!base_type || base_type->type !=3D SYM_FN))
+		apply_constexpr_const(decl);
+
 	if (!is_typedef && ctx.autotype && !ctx.has_auto &&
 	    base_type =3D=3D &autotype_ctype) {
 		struct symbol *prev =3D lookup_symbol(ident, NS_SYMBOL | NS_TYPEDEF);
@@ -3317,6 +3372,12 @@ struct token *external_declaration(struct token *t=
oken, struct symbol_list **lis
 			}
 		}
 	} else if (base_type && base_type->type =3D=3D SYM_FN) {
+		if (ctx.is_constexpr) {
+			sparse_error(
+				decl->pos,
+				"function '%s' cannot be declared constexpr",
+				show_ident(decl->ident));
+		}
 		if (base_type->ctype.base_type =3D=3D &autotype_ctype) {
 			sparse_error(decl->pos, "'%s()' has %s return type",
 				     show_ident(decl->ident),
@@ -3360,7 +3421,7 @@ struct token *external_declaration(struct token *to=
ken, struct symbol_list **lis
 	for (;;) {
 		if (!is_typedef && match_op(token, '=3D')) {
 			struct token *next =3D token->next;
-			bool mark_underspec =3D decl->c23_auto;
+			bool mark_underspec =3D decl->c23_auto || ctx.is_constexpr;
 			if (mark_underspec)
 				decl->underspecified =3D 1;
 			token =3D initializer(&decl->initializer, next);
@@ -3403,7 +3464,7 @@ struct token *external_declaration(struct token *to=
ken, struct symbol_list **lis
 			}
 		}
=20
-		if (!is_typedef && decl->c23_auto &&
+		if (!is_typedef && (decl->c23_auto || ctx.is_constexpr) &&
 		    (!decl->ctype.base_type ||
 		     decl->ctype.base_type->type !=3D SYM_FN)) {
 			struct symbol *prev;
@@ -3452,6 +3513,34 @@ struct token *external_declaration(struct token *t=
oken, struct symbol_list **lis
 			}
 		}
=20
+		if (ctx.is_constexpr) {
+			if (is_typedef)
+				sparse_error(
+					decl->pos,
+					"constexpr cannot be used with typedef");
+			else if (ctx.storage_class & MOD_EXTERN)
+				sparse_error(
+					decl->pos,
+					"constexpr cannot be used with extern");
+			else if ((ctx.storage_class & MOD_REGISTER) &&
+				 toplevel(block_scope))
+				sparse_error(
+					decl->pos,
+					"constexpr register variable '%s' at file scope",
+					show_ident(decl->ident));
+			else if (decl->ctype.modifiers & MOD_TLS)
+				sparse_error(
+					decl->pos,
+					"constexpr cannot be used with thread_local");
+			else if (!decl->initializer &&
+				 (!decl->ctype.base_type ||
+				  decl->ctype.base_type->type !=3D SYM_FN))
+				sparse_error(
+					decl->pos,
+					"constexpr variable '%s' without initializer",
+					show_ident(decl->ident));
+		}
+
 		if (ctx.has_alignas) {
 			if (is_typedef)
 				sparse_error(decl->pos,
@@ -3507,6 +3596,11 @@ struct token *external_declaration(struct token *t=
oken, struct symbol_list **lis
 		if (is_typedef)
 			decl->ctype.modifiers |=3D MOD_USERTYPE;
=20
+		base_type =3D decl->ctype.base_type;
+		if (ctx.is_constexpr && !is_typedef &&
+		    (!base_type || base_type->type !=3D SYM_FN))
+			apply_constexpr_const(decl);
+
 		bind_symbol(decl, ident, is_typedef ? NS_TYPEDEF: NS_SYMBOL);
=20
 		/* Function declarations are automatically extern unless specifically =
static */
diff --git a/show-parse.c b/show-parse.c
index 78d86e20e93a..0a277ef67aac 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -119,31 +119,32 @@ static const char *show_modifiers(unsigned long mod=
, int term)
 	} *m;
=20
 	static struct mod_name mod_names[] =3D {
-		{MOD_AUTO,		"auto"},
-		{MOD_EXTERN,		"extern"},
-		{MOD_REGISTER,		"register"},
-		{MOD_STATIC,		"static"},
-		{MOD_INLINE,		"inline"},
-		{MOD_CONST,		"const"},
-		{MOD_RESTRICT,		"restrict"},
-		{MOD_VOLATILE,		"volatile"},
-		{MOD_ADDRESSABLE,	"[addressable]"},
-		{MOD_ASSIGNED,		"[assigned]"},
-		{MOD_ATOMIC,		"[atomic]"},
-		{MOD_BITWISE,		"[bitwise]"},
-		{MOD_EXPLICITLY_SIGNED,	"[explicitly-signed]"},
-		{MOD_GNU_INLINE,	"[gnu_inline]"},
-		{MOD_NOCAST,		"[nocast]"},
-		{MOD_NODEREF,		"[noderef]"},
-		{MOD_NORETURN,		"[noreturn]"},
-		{MOD_PURE,		"[pure]"},
-		{MOD_SAFE,		"[safe]"},
-		{MOD_SIGNED,		"[signed]"},
-		{MOD_TLS,		"[tls]"},
-		{MOD_TOPLEVEL,		"[toplevel]"},
-		{MOD_UNSIGNED,		"[unsigned]"},
-		{MOD_UNUSED,		"[unused]"},
-		{MOD_USERTYPE,		"[usertype]"},
+		{ MOD_AUTO, "auto" },
+		{ MOD_EXTERN, "extern" },
+		{ MOD_REGISTER, "register" },
+		{ MOD_STATIC, "static" },
+		{ MOD_CONSTEXPR, "constexpr" },
+		{ MOD_INLINE, "inline" },
+		{ MOD_CONST, "const" },
+		{ MOD_RESTRICT, "restrict" },
+		{ MOD_VOLATILE, "volatile" },
+		{ MOD_ADDRESSABLE, "[addressable]" },
+		{ MOD_ASSIGNED, "[assigned]" },
+		{ MOD_ATOMIC, "[atomic]" },
+		{ MOD_BITWISE, "[bitwise]" },
+		{ MOD_EXPLICITLY_SIGNED, "[explicitly-signed]" },
+		{ MOD_GNU_INLINE, "[gnu_inline]" },
+		{ MOD_NOCAST, "[nocast]" },
+		{ MOD_NODEREF, "[noderef]" },
+		{ MOD_NORETURN, "[noreturn]" },
+		{ MOD_PURE, "[pure]" },
+		{ MOD_SAFE, "[safe]" },
+		{ MOD_SIGNED, "[signed]" },
+		{ MOD_TLS, "[tls]" },
+		{ MOD_TOPLEVEL, "[toplevel]" },
+		{ MOD_UNSIGNED, "[unsigned]" },
+		{ MOD_UNUSED, "[unused]" },
+		{ MOD_USERTYPE, "[usertype]" },
 	};
=20
 	for (i =3D 0; i < ARRAY_SIZE(mod_names); i++) {
diff --git a/symbol.c b/symbol.c
index b0bdf0b1122f..fc11e1bbcec3 100644
--- a/symbol.c
+++ b/symbol.c
@@ -563,7 +563,7 @@ static struct symbol * examine_node_type(struct symbo=
l *sym)
 		sym->ctype.alignment =3D alignment;
=20
 	/* Unsized array? The size might come from the initializer.. */
-	if (bit_size < 0 && base_type->type =3D=3D SYM_ARRAY) {
+	if (bit_size < 0 && base_type->type =3D=3D SYM_ARRAY && !base_type->arr=
ay_size) {
 		struct expression *initializer =3D get_symbol_initializer(sym);
 		if (initializer) {
 			struct symbol *node_type =3D base_type->ctype.base_type;
@@ -872,6 +872,10 @@ void bind_symbol_with_scope(struct symbol *sym, stru=
ct ident *ident, enum namesp
 	if (ns =3D=3D NS_SYMBOL && toplevel(scope)) {
 		unsigned mod =3D MOD_ADDRESSABLE | MOD_TOPLEVEL;
=20
+		if ((sym->ctype.modifiers & MOD_CONSTEXPR) &&
+		    !(sym->ctype.modifiers & MOD_EXTERN))
+			sym->ctype.modifiers |=3D MOD_STATIC;
+
 		inherit_static(sym);
=20
 		scope =3D global_scope;
diff --git a/symbol.h b/symbol.h
index 61ca70afe83b..f8556fdf3b86 100644
--- a/symbol.h
+++ b/symbol.h
@@ -117,6 +117,7 @@ struct decl_state {
 	unsigned char packed;
 	unsigned char has_auto;
 	unsigned char has_alignas;
+	unsigned char is_constexpr;
 	unsigned char designated_init;
 	unsigned char transparent_union;
 };
@@ -254,10 +255,10 @@ struct symbol {
=20
 #define MOD_GNU_INLINE		0x00010000
 #define MOD_USERTYPE		0x00020000
-     // MOD UNUSED		0x00040000
-     // MOD UNUSED		0x00080000
-     // MOD UNUSED		0x00100000
-     // MOD UNUSED		0x00200000
+#define MOD_CONSTEXPR 0x00040000
+// MOD UNUSED		0x00080000
+// MOD UNUSED		0x00100000
+// MOD UNUSED		0x00200000
=20
 #define MOD_UNUSED		0x00400000
 #define MOD_SAFE		0x00800000	// non-null/non-trapping pointer
@@ -275,7 +276,7 @@ struct symbol {
 #define MOD_ESIGNED	(MOD_SIGNED | MOD_EXPLICITLY_SIGNED)
 #define MOD_SIGNEDNESS	(MOD_SIGNED | MOD_UNSIGNED | MOD_EXPLICITLY_SIGNE=
D)
 #define MOD_SPECIFIER	MOD_SIGNEDNESS
-#define MOD_IGNORE	(MOD_STORAGE | MOD_ACCESS | MOD_USERTYPE | MOD_EXPLIC=
ITLY_SIGNED | MOD_EXT_VISIBLE | MOD_UNUSED | MOD_GNU_INLINE)
+#define MOD_IGNORE	(MOD_STORAGE | MOD_ACCESS | MOD_USERTYPE | MOD_EXPLIC=
ITLY_SIGNED | MOD_EXT_VISIBLE | MOD_UNUSED | MOD_GNU_INLINE | MOD_CONSTEX=
PR)
 #define MOD_QUALIFIER	(MOD_CONST | MOD_VOLATILE | MOD_RESTRICT)
 #define MOD_PTRINHERIT	(MOD_QUALIFIER | MOD_ATOMIC | MOD_NODEREF | MOD_N=
ORETURN | MOD_NOCAST)
 /* modifiers preserved by typeof() operator */
@@ -287,9 +288,9 @@ struct symbol {
 /* do not warn when these are duplicated */
 #define MOD_DUP_OK	(MOD_UNUSED|MOD_GNU_INLINE)
 /* must be part of the declared symbol, not its type */
-#define MOD_DECLARE	(MOD_STORAGE|MOD_INLINE|MOD_TLS|MOD_GNU_INLINE|MOD_U=
NUSED|MOD_PURE|MOD_NORETURN|MOD_EXT_VISIBLE)
-
-
+#define MOD_DECLARE                                                     =
    \
+	(MOD_STORAGE | MOD_INLINE | MOD_TLS | MOD_GNU_INLINE | MOD_UNUSED | \
+	 MOD_PURE | MOD_NORETURN | MOD_EXT_VISIBLE | MOD_CONSTEXPR)
=20
 /* Current parsing/evaluation function */
 extern struct symbol *current_fn;
diff --git a/validation/c23-constexpr-error.c b/validation/c23-constexpr-=
error.c
new file mode 100644
index 000000000000..41ee86d7ae63
--- /dev/null
+++ b/validation/c23-constexpr-error.c
@@ -0,0 +1,92 @@
+constexpr int no_init;
+constexpr int foo(void)
+{
+	return 0;
+}
+typedef constexpr int my_int;
+extern constexpr int ext =3D 1;
+register constexpr int reg =3D 1;
+void bar(constexpr int p)
+{
+}
+struct s {
+	constexpr int m;
+};
+constexpr constexpr int double_ce =3D 1;
+int non_const =3D 5;
+constexpr int bad_init =3D non_const;
+thread_local constexpr int tls =3D 1;
+constexpr struct empty_s {
+	int a;
+};
+constexpr volatile int cv =3D 1;
+constexpr _Atomic int ca =3D 1;
+constexpr int *restrict cr =3D nullptr;
+constexpr int *bad_ptr =3D &non_const;
+constexpr const char *bad_str =3D "hi";
+constexpr int bad_flt_ice =3D 1.0;
+constexpr unsigned int neg_to_u =3D -1;
+constexpr signed char over_sc =3D 200;
+constexpr bool bad_bool =3D 2;
+constexpr float inexact_int =3D 16777217;
+constexpr float inexact_dbl =3D 0.1;
+extern int already_in_scope;
+constexpr int already_in_scope =3D 1;
+
+struct pwrap {
+	int *p;
+	unsigned char u;
+};
+constexpr struct pwrap bad_nested =3D { &non_const, 300 };
+
+void assign_and_vla_test(int n)
+{
+	constexpr int c =3D 10;
+	c =3D 20;
+
+	constexpr int *cp =3D nullptr;
+	cp =3D nullptr;
+
+	constexpr int arr[2] =3D { 1, 2 };
+	arr[0] =3D 3;
+
+	constexpr int (*vla)[n] =3D nullptr;
+	(void)vla;
+}
+
+/*
+ * check-name: C23 constexpr error cases
+ * check-command: sparse -std=3Dc23 $file
+ *
+ * check-error-start
+c23-constexpr-error.c:1:15: error: constexpr variable 'no_init' without =
initializer
+c23-constexpr-error.c:2:15: error: function 'foo' cannot be declared con=
stexpr
+c23-constexpr-error.c:6:23: error: constexpr cannot be used with typedef
+c23-constexpr-error.c:7:22: error: constexpr cannot be used with extern
+c23-constexpr-error.c:8:24: error: constexpr register variable 'reg' at =
file scope
+c23-constexpr-error.c:9:10: error: parameter 'p' cannot be declared cons=
texpr
+c23-constexpr-error.c:13:23: error: struct or union member 'm' cannot be=
 declared constexpr
+c23-constexpr-error.c:15:21: error: duplicate constexpr
+c23-constexpr-error.c:18:28: error: constexpr cannot be used with thread=
_local
+c23-constexpr-error.c:21:2: error: constexpr in empty declaration
+c23-constexpr-error.c:34:15: error: underspecified declaration of 'alrea=
dy_in_scope', which is already declared in this scope
+c23-constexpr-error.c:17:26: error: non-constant initializer for constex=
pr object
+c23-constexpr-error.c:22:24: error: constexpr variable 'cv' cannot have =
volatile, atomic, or restrict type
+c23-constexpr-error.c:23:23: error: constexpr variable 'ca' cannot have =
volatile, atomic, or restrict type
+c23-constexpr-error.c:24:15: error: constexpr variable 'cr' cannot have =
volatile, atomic, or restrict type
+c23-constexpr-error.c:25:27: error: constexpr pointer initializer is not=
 null
+c23-constexpr-error.c:26:33: error: constexpr pointer initializer is not=
 null
+c23-constexpr-error.c:27:29: error: constexpr integer initializer is not=
 an integer constant expression
+c23-constexpr-error.c:28:35: error: constexpr initializer not representa=
ble in target type
+c23-constexpr-error.c:29:33: error: constexpr initializer not representa=
ble in target type
+c23-constexpr-error.c:30:27: error: constexpr initializer not representa=
ble in target type
+c23-constexpr-error.c:31:31: error: constexpr initializer not representa=
ble in target type
+c23-constexpr-error.c:32:31: error: constexpr initializer not representa=
ble in target type
+c23-constexpr-error.c:40:40: error: constexpr pointer initializer is not=
 null
+c23-constexpr-error.c:40:51: error: constexpr initializer not representa=
ble in target type
+c23-constexpr-error.c:45:9: error: assignment to const expression
+c23-constexpr-error.c:48:9: error: assignment to const expression
+c23-constexpr-error.c:51:12: error: assignment to const expression
+c23-constexpr-error.c:53:23: error: constexpr variable 'vla' cannot have=
 variably modified type
+ * check-error-end
+ */
diff --git a/validation/c23-constexpr-self-init.c b/validation/c23-conste=
xpr-self-init.c
new file mode 100644
index 000000000000..2af16572a778
--- /dev/null
+++ b/validation/c23-constexpr-self-init.c
@@ -0,0 +1,41 @@
+/*
+ * Verify that self-referencing constexpr initializers do not cause
+ * infinite recursion or stack overflow in constant_symbol_value().
+ */
+
+static constexpr int a =3D a;
+static constexpr int b =3D b + 1;
+
+static void test_local(void)
+{
+	constexpr int x =3D x;
+	constexpr int y =3D y + 1;
+	int c =3D 5;
+	{
+		constexpr int c =3D c;
+		(void)c;
+	}
+	constexpr int sz =3D sizeof(sz);
+	(void)sz;
+	(void)c;
+}
+
+static void test_eval(void)
+{
+	_Static_assert(b =3D=3D 0, "");
+}
+
+/*
+ * check-name: C23 constexpr self-initialization recursion
+ * check-command: sparse -std=3Dc23 $file
+ *
+ * check-error-start
+c23-constexpr-self-init.c:7:26: error: underspecified symbol 'b' used in=
 its own initializer
+c23-constexpr-self-init.c:25:26: error: bad constant expression
+c23-constexpr-self-init.c:6:26: error: underspecified symbol 'a' used in=
 its own initializer
+c23-constexpr-self-init.c:11:27: error: underspecified symbol 'x' used i=
n its own initializer
+c23-constexpr-self-init.c:12:27: error: underspecified symbol 'y' used i=
n its own initializer
+c23-constexpr-self-init.c:15:35: error: underspecified symbol 'c' used i=
n its own initializer
+c23-constexpr-self-init.c:18:35: error: underspecified symbol 'sz' used =
in its own initializer
+ * check-error-end
+ */
diff --git a/validation/c23-constexpr.c b/validation/c23-constexpr.c
new file mode 100644
index 000000000000..ec0cf227154f
--- /dev/null
+++ b/validation/c23-constexpr.c
@@ -0,0 +1,100 @@
+#ifdef __CHECKER__
+#define ASSERT_TYPE(expr, T) _Static_assert([typeof(expr)] =3D=3D [T], "=
")
+#else
+#define ASSERT_TYPE(expr, T) \
+	_Static_assert(_Generic((typeof(expr) *)0, typeof(T) *: 1, default: 0),=
 "")
+#endif
+
+static constexpr int N =3D 5;
+static constexpr auto A =3D 10;
+static constexpr double D =3D 2.5;
+static constexpr int TRUNC =3D (int)D;
+constexpr int FILE_CE =3D 7;
+
+struct inner_c {
+	int a;
+	int b;
+};
+
+struct outer_c {
+	int x;
+	struct inner_c in;
+};
+
+static constexpr struct outer_c OUTER =3D { 1, { 2, 42 } };
+static constexpr struct outer_c OUTER_DESIG =3D { .in.b =3D 99 };
+static constexpr struct outer_c OUTER_COPY =3D OUTER;
+
+typedef int pair_t[2];
+static constexpr pair_t CE_PAIR =3D { 10, 20 };
+
+static constexpr int *NP =3D nullptr;
+static constexpr const int *CNP =3D (void *)0;
+static constexpr typeof(nullptr) NULLP =3D nullptr;
+static constexpr int *NP2 =3D NP;
+
+static constexpr char STR[] =3D "ok";
+static constexpr bool B0 =3D 0;
+static constexpr bool B1 =3D true;
+static constexpr float EXACT_F =3D 16777216;
+
+struct large_c {
+	int pad[1024];
+	int tail;
+};
+
+static constexpr struct large_c LARGE =3D { .tail =3D 77 };
+
+enum my_enum { ENUM_VAL =3D N * 2 };
+
+struct bitfield_test {
+	int b : N;
+};
+
+static int array[N];
+
+static void test(int val)
+{
+	static_assert(N =3D=3D 5);
+	static_assert(A =3D=3D 10);
+	static_assert(TRUNC =3D=3D 2);
+	static_assert(FILE_CE =3D=3D 7);
+	static_assert(OUTER.in.b =3D=3D 42);
+	static_assert(OUTER_DESIG.in.b =3D=3D 99);
+	static_assert(OUTER_COPY.in.b =3D=3D 42);
+	static_assert(LARGE.tail =3D=3D 77);
+	static_assert(sizeof(array) =3D=3D 5 * sizeof(int));
+	static_assert(ENUM_VAL =3D=3D 10);
+	static_assert(sizeof(STR) =3D=3D 3);
+	static_assert(!B0 && B1);
+	static_assert((int)EXACT_F =3D=3D 16777216);
+
+	ASSERT_TYPE(A, const int);
+	ASSERT_TYPE(NP, int *const);
+	ASSERT_TYPE(CNP, const int *const);
+	ASSERT_TYPE(NULLP, const typeof(nullptr));
+	ASSERT_TYPE(NP2, int *const);
+	ASSERT_TYPE(CE_PAIR[0], const int);
+
+	/* Ensure typedef pair_t itself was not mutated to const */
+	pair_t mut_pair =3D { 1, 2 };
+	mut_pair[0] =3D 3;
+
+	constexpr int LOCAL =3D 3;
+	constexpr register int REG_LOCAL =3D 4;
+	static_assert(LOCAL =3D=3D 3);
+	static_assert(REG_LOCAL =3D=3D 4);
+	switch (val) {
+	case LOCAL:
+	case REG_LOCAL:
+		break;
+	}
+
+	const int *p =3D &N;
+	(void)p;
+}
+
+/*
+ * check-name: C23 constexpr object declarations
+ * check-command: sparse -std=3Dc23 $file
+ */

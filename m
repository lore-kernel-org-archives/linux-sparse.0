Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256432;
	b=QZhD0kKT8t2luErEWVR2UsrUbx1+ynm31W+sVdRho00X1fnmR+7cOVsqQURkmpqk2DoT
	 ISNQfDdlDBWcBPW5Z6qDat+wSiyurl6brEYellxpR0HiP8esU5sjBI+r+NdG+KqJREUhC
	 h0zdUxvcDybNGbL72xhbW10g/L7nMnXLTl2Q2oHqYmN6WyeqP48bBehixkTgow84uvwRU
	 w3IIQglU1EAtRJbc3leSoFN0Oe4WsgtbXrzcns9RPuBj9LcZ57K4AQ9CIEMOi/sD15PRr
	 3b8Am/QID8u5xoovpo7XfH93gkUpDb9bzQ1MHFkRrhxR+aUc6f4t4Qn6rEe/cNNmm6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=io/igg1OVLGS4dHMzgc/UaHqAbIPA3PkQVKYhG58cg0=;
	b=YM4kij/7Bnj6JbXD1NUqfR/J7r+/Z8W2CX+YAYqKWEcO1xZnVcl6mkyP2TQPN25k6ilz
	 Z14r57SNDu4A0mNLgOU1DB4HpROGkLnvXGDIkeOZq4w3xWZ6+kib4qCDwZUxOp6sc9eQ+
	 nlyAya0RbOLAsdVQAwtRxdH+BxYXsy8u/+3g5buKdGP+7XM6k7E/OwWQqidC+3jDE+LK+
	 9Q7z5HgjSfSixxPhw7x3lg5uFnN4KIwJmi8Ie9Ykc5ntes7yVxGCGdSgNWavXhjOqYVrD
	 SSwKgNmWl72HTgvSUIIue0QgYC05ORiGBljSBmDzKPOCmsAp39lVY/78y4YdrqaFtsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=dol3fz5u;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683A8606A330
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 683A8606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=dol3fz5u
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhMF0Jn8z1XM0nl;
	Mon,  9 Nov 2026 20:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256415; x=1796848416; bh=io/ig
	g1OVLGS4dHMzgc/UaHqAbIPA3PkQVKYhG58cg0=; b=dol3fz5utb4bY5cyGe0Ex
	gbRA+ExxZZNHA9vRcl1Rpg8kLTSjjuQy1+jeWm1WdI3vE8pWS94ioxyfxlFRgB+Q
	wek81E/a7t5jtd1Q7m1aKAtyjc9+Or4vO64rC7vi8kwVD9pN88B9Iqor7t1Jd6Uz
	YV17/nLYFURwvO8zXp0bKrOr028UyK/RqJJiKmxxgEn4Dg3TDc7VrloZ/Xu4vJiD
	Hr2AUYFMbD80NxUE0oFAzfU0n5NjejcHSoMpcqbDKSzCBusV9h9S9S0empVWdY30
	JiixVasJ7RI19Oqcb7STh7hBvMioP9c9HozC/M25c2pa0JfHNKOKNe0RcigeHEqK
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ddmV2xrbTKYl; Mon,  9 Nov 2026 20:33:35 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLz1VK5z1XLwXF;
	Mon,  9 Nov 2026 20:33:31 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 31/73] context: Add "conditional context increment" model
Date: Mon,  9 Nov 2026 12:32:17 -0800
Message-ID: <20261109203259.362845-32-bvanassche@acm.org>
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

From: Linus Torvalds <torvalds@linux-foundation.org>

Use a negative output parameter to the "context" attribute to indicate
that the context is increased conditionally.

Support "trylock()" kinds of functions that return success if the lock
operation succeeded, matching Linux kernel commit 4a557a5d1a61 ("sparse:
introduce conditional lock acquire function attribute") for
refcount_dec_and_lock() and friends.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[ bvanassche: Rewrite commit message in imperative mood, support multiple
  context attributes in linearize_call_expression(), validate conditional
  context function definitions in check_context(), and extend
  validation/context.c ]
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 linearize.c          |  42 ++++++++-
 sparse.c             | 202 +++++++++++++++++++++++++++++++++++++++++--
 validation/context.c | 101 +++++++++++++++++++---
 3 files changed, 318 insertions(+), 27 deletions(-)

diff --git a/linearize.c b/linearize.c
index c6ec3703b149..24b402622b83 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1539,19 +1539,20 @@ static pseudo_t linearize_call_expression(struct =
entrypoint *ep, struct expressi
 	add_one_insn(ep, insn);
=20
 	if (ctype) {
+		struct basic_block *post_call =3D NULL;
+
 		FOR_EACH_PTR(ctype->contexts, context) {
 			int in =3D context->in;
 			int out =3D context->out;
 			int check =3D 0;
 			int context_diff;
+
+			if (out < 0)
+				continue;
 			if (in < 0) {
 				check =3D 1;
 				in =3D 0;
 			}
-			if (out < 0) {
-				check =3D 0;
-				out =3D 0;
-			}
 			context_diff =3D out - in;
 			if (check || context_diff) {
 				insn =3D alloc_instruction(OP_CONTEXT, 0);
@@ -1562,6 +1563,39 @@ static pseudo_t linearize_call_expression(struct e=
ntrypoint *ep, struct expressi
 			}
 		} END_FOR_EACH_PTR(context);
=20
+		FOR_EACH_PTR(ctype->contexts, context) {
+			int in =3D context->in;
+			int out =3D context->out;
+
+			if (out >=3D 0)
+				continue;
+			if (retval =3D=3D VOID) {
+				warning(expr->pos, "nonsensical conditional output context with no c=
ondition");
+				continue;
+			}
+			if (in) {
+				warning(expr->pos, "nonsensical conditional input context");
+				continue;
+			}
+			if (!post_call) {
+				struct basic_block *set_context;
+				post_call =3D alloc_basic_block(ep, expr->pos);
+				set_context =3D alloc_basic_block(ep, expr->pos);
+				add_branch(ep, retval, set_context, post_call);
+				set_activeblock(ep, set_context);
+			}
+			insn =3D alloc_instruction(OP_CONTEXT, 0);
+			insn->increment =3D -out;
+			insn->check =3D 0;
+			insn->context_expr =3D context->context;
+			add_one_insn(ep, insn);
+		} END_FOR_EACH_PTR(context);
+
+		if (post_call) {
+			add_goto(ep, post_call);
+			set_activeblock(ep, post_call);
+		}
+
 		if (ctype->modifiers & MOD_NORETURN)
 			add_unreachable(ep);
 	}
diff --git a/sparse.c b/sparse.c
index 883a5edec5b1..19c6ba46e012 100644
--- a/sparse.c
+++ b/sparse.c
@@ -79,9 +79,168 @@ static int imbalance(struct entrypoint *ep, struct ba=
sic_block *bb, int entry, i
 	return -1;
 }
=20
-static int check_bb_context(struct entrypoint *ep, struct basic_block *b=
b, int entry, int exit);
+struct cond_context_state {
+	int cond_out;
+	bool saw_base_out;
+	bool saw_cond_out;
+	bool all_zero;
+	bool all_nonzero;
+	struct basic_block *any_exit_bb;
+};
+
+static bool is_pure_return_bb(struct basic_block *bb)
+{
+	struct instruction *insn, *last =3D NULL;
+
+	if (!bb)
+		return false;
+	FOR_EACH_PTR(bb->insns, insn) {
+		if (!insn->bb)
+			continue;
+		if (insn->opcode =3D=3D OP_CONTEXT || insn->opcode =3D=3D OP_CALL ||
+		    insn->opcode =3D=3D OP_INLINED_CALL || insn->opcode =3D=3D OP_ASM)
+			return false;
+		last =3D insn;
+	} END_FOR_EACH_PTR(insn);
+	return last && last->opcode =3D=3D OP_RET;
+}
+
+static int known_cond_on_edge(pseudo_t cond, struct basic_block *from, s=
truct basic_block *to)
+{
+	int hops;
+
+	for (hops =3D 0; from && to && hops < 4; hops++) {
+		struct instruction *br =3D last_instruction(from->insns);
+		if (br && br->opcode =3D=3D OP_CBR && br->cond =3D=3D cond &&
+		    br->bb_true !=3D br->bb_false) {
+			if (to =3D=3D br->bb_true)
+				return 1;
+			if (to =3D=3D br->bb_false)
+				return 0;
+		}
+		if (ptr_list_size((struct ptr_list *)from->parents) !=3D 1)
+			break;
+		to =3D from;
+		from =3D first_basic_block(from->parents);
+		if (from =3D=3D to)
+			break;
+	}
+	return -1;
+}
+
+static int return_truth_on_edge(pseudo_t val, struct basic_block *from,
+				struct basic_block *ret_bb, int depth)
+{
+	struct instruction *def;
+	int known;
+
+	if (!val || val =3D=3D VOID || depth > 8)
+		return -1;
+	if (val->type =3D=3D PSEUDO_VAL)
+		return val->value !=3D 0 ? 1 : 0;
+
+	known =3D known_cond_on_edge(val, from, ret_bb);
+	if (known >=3D 0)
+		return known;
+
+	if (val->type !=3D PSEUDO_REG && val->type !=3D PSEUDO_PHI)
+		return -1;
+	def =3D val->def;
+	if (!def)
+		return -1;
+
+	switch (def->opcode) {
+	case OP_PHI: {
+		struct basic_block *cur =3D from;
+		int hops;
+		for (hops =3D 0; cur && hops < 4; hops++) {
+			pseudo_t phi;
+			FOR_EACH_PTR(def->phi_list, phi) {
+				if (!phi || phi =3D=3D VOID || !phi->def)
+					continue;
+				if (phi->def->bb =3D=3D cur)
+					return return_truth_on_edge(phi->def->phi_src,
+								    cur, ret_bb, depth + 1);
+			} END_FOR_EACH_PTR(phi);
+			if (ptr_list_size((struct ptr_list *)cur->parents) !=3D 1)
+				break;
+			cur =3D first_basic_block(cur->parents);
+		}
+		return -1;
+	}
+	case OP_PHISOURCE:
+		return return_truth_on_edge(def->phi_src, def->bb, ret_bb, depth + 1);
+	case OP_ZEXT:
+	case OP_SEXT:
+		if (def->orig_type && def->size >=3D def->orig_type->bit_size)
+			return return_truth_on_edge(def->src, from, ret_bb, depth + 1);
+		return -1;
+	case OP_SET_EQ:
+		if (def->src2 && def->src2->type =3D=3D PSEUDO_VAL && def->src2->value=
 =3D=3D 0) {
+			int t =3D return_truth_on_edge(def->src1, from, ret_bb, depth + 1);
+			return t >=3D 0 ? !t : -1;
+		}
+		return -1;
+	case OP_SET_NE:
+		if (def->src2 && def->src2->type =3D=3D PSEUDO_VAL && def->src2->value=
 =3D=3D 0)
+			return return_truth_on_edge(def->src1, from, ret_bb, depth + 1);
+		return -1;
+	case OP_SEL: {
+		int ct =3D return_truth_on_edge(def->cond, from, ret_bb, depth + 1);
+		int tt, ft;
+		if (ct =3D=3D 1)
+			return return_truth_on_edge(def->src2, from, ret_bb, depth + 1);
+		if (ct =3D=3D 0)
+			return return_truth_on_edge(def->src3, from, ret_bb, depth + 1);
+		tt =3D return_truth_on_edge(def->src2, from, ret_bb, depth + 1);
+		ft =3D return_truth_on_edge(def->src3, from, ret_bb, depth + 1);
+		return (tt >=3D 0 && tt =3D=3D ft) ? tt : -1;
+	}
+	default:
+		return -1;
+	}
+}
+
+static int check_exit_edge(struct entrypoint *ep, struct basic_block *fr=
om,
+			   struct basic_block *ret_bb, struct instruction *ret_insn,
+			   int entry, int exit, struct cond_context_state *cs)
+{
+	struct basic_block *diag_bb =3D from ? from : ret_bb;
+	int truth;
+
+	if (!cs || !cs->cond_out)
+		return entry !=3D exit ? imbalance(ep, ret_bb, entry, exit, "wrong cou=
nt at exit") : 0;
+
+	if (!ret_insn->src || ret_insn->src =3D=3D VOID)
+		return imbalance(ep, diag_bb, entry, exit + cs->cond_out, "wrong count=
 at exit");
+
+	truth =3D return_truth_on_edge(ret_insn->src, from, ret_bb, 0);
+	if (!cs->any_exit_bb)
+		cs->any_exit_bb =3D diag_bb;
+	if (entry =3D=3D exit)
+		cs->saw_base_out =3D true;
+	if (entry =3D=3D exit + cs->cond_out)
+		cs->saw_cond_out =3D true;
+	if (truth !=3D 0)
+		cs->all_zero =3D false;
+	if (truth !=3D 1)
+		cs->all_nonzero =3D false;
+
+	if (truth =3D=3D 0)
+		return entry !=3D exit ? imbalance(ep, diag_bb, entry, exit, "wrong co=
unt at exit") : 0;
+	if (truth =3D=3D 1)
+		return entry !=3D exit + cs->cond_out ?
+			imbalance(ep, diag_bb, entry, exit + cs->cond_out, "wrong count at ex=
it") : 0;
+	if (entry !=3D exit && entry !=3D exit + cs->cond_out)
+		return imbalance(ep, diag_bb, entry, exit, "wrong count at exit");
+	return 0;
+}
=20
-static int check_children(struct entrypoint *ep, struct basic_block *bb,=
 int entry, int exit)
+static int check_bb_context(struct entrypoint *ep, struct basic_block *b=
b,
+			    int entry, int exit, struct cond_context_state *cs);
+
+static int check_children(struct entrypoint *ep, struct basic_block *bb,
+			  int entry, int exit, struct cond_context_state *cs)
 {
 	struct instruction *insn;
 	struct basic_block *child;
@@ -90,16 +249,23 @@ static int check_children(struct entrypoint *ep, str=
uct basic_block *bb, int ent
 	if (!insn)
 		return 0;
 	if (insn->opcode =3D=3D OP_RET)
-		return entry !=3D exit ? imbalance(ep, bb, entry, exit, "wrong count a=
t exit") : 0;
+		return check_exit_edge(ep, NULL, bb, insn, entry, exit, cs);
=20
 	FOR_EACH_PTR(bb->children, child) {
-		if (check_bb_context(ep, child, entry, exit))
+		if (cs && cs->cond_out && is_pure_return_bb(child)) {
+			if (check_exit_edge(ep, bb, child, last_instruction(child->insns),
+					    entry, exit, cs))
+				return -1;
+			continue;
+		}
+		if (check_bb_context(ep, child, entry, exit, cs))
 			return -1;
 	} END_FOR_EACH_PTR(child);
 	return 0;
 }
=20
-static int check_bb_context(struct entrypoint *ep, struct basic_block *b=
b, int entry, int exit)
+static int check_bb_context(struct entrypoint *ep, struct basic_block *b=
b,
+			    int entry, int exit, struct cond_context_state *cs)
 {
 	if (!bb)
 		return 0;
@@ -115,7 +281,7 @@ static int check_bb_context(struct entrypoint *ep, st=
ruct basic_block *bb, int e
 	if (entry < 0)
 		return imbalance(ep, bb, entry, exit, "unexpected unlock");
=20
-	return check_children(ep, bb, entry, exit);
+	return check_children(ep, bb, entry, exit, cs);
 }
=20
 static void check_cast_instruction(struct instruction *insn)
@@ -260,11 +426,29 @@ static void check_context(struct entrypoint *ep)
=20
 	check_instructions(ep);
=20
+	struct cond_context_state cs =3D {
+		.all_zero =3D true,
+		.all_nonzero =3D true,
+	};
+
 	FOR_EACH_PTR(sym->ctype.contexts, context) {
-		in_context +=3D context->in;
-		out_context +=3D context->out;
+		int in =3D context->in;
+		int out =3D context->out;
+
+		if (in > 0)
+			in_context +=3D in;
+		if (out > 0)
+			out_context +=3D out;
+		else if (out < 0)
+			cs.cond_out +=3D -out;
 	} END_FOR_EACH_PTR(context);
-	check_bb_context(ep, ep->entry->bb, in_context, out_context);
+	if (!check_bb_context(ep, ep->entry->bb, in_context, out_context, &cs) =
&&
+	    cs.cond_out > 0 && cs.any_exit_bb) {
+		if ((!cs.all_zero && !cs.saw_cond_out) ||
+		    (!cs.all_nonzero && !cs.saw_base_out))
+			imbalance(ep, cs.any_exit_bb, in_context,
+				  out_context + cs.cond_out, "wrong count at exit");
+	}
 }
=20
 /* list_compound_symbol - symbol info for arrays, structures, unions */
diff --git a/validation/context.c b/validation/context.c
index b9500dc7508d..3330482c2195 100644
--- a/validation/context.c
+++ b/validation/context.c
@@ -10,6 +10,10 @@ static void r(void) __attribute__((context(1,0)))
 	__context__(-1);
 }
=20
+// Negative output means "conditional positive output"
+extern int cond_get(void) __attribute((context(0,-1)));
+extern void nonsensical_cond_get(void) __attribute((context(0,-1)));
+
 extern int _ca(int fail);
 #define ca(fail) __cond_lock(_ca(fail))
=20
@@ -19,6 +23,17 @@ static void good_paired1(void)
 	r();
 }
=20
+static void good_conditional(void)
+{
+	if (cond_get())
+		r();
+}
+
+static void nonsensical_conditional(void)
+{
+	nonsensical_cond_get();
+}
+
 static void good_paired2(void)
 {
 	a();
@@ -314,23 +329,81 @@ static void warn_cond_lock1(void)
         condition2 =3D 1; /* do stuff */
     r();
 }
+
+static int good_trylock_def(int ok) __attribute__((context(0, -1)))
+{
+	if (ok) {
+		__context__(1);
+		return 1;
+	}
+	return 0;
+}
+
+static int good_trylock_wrap(void) __attribute__((context(0, -1)))
+{
+	return cond_get();
+}
+
+static int good_trylock_stub(void) __attribute__((context(0, -1)))
+{
+	return 0;
+}
+
+extern int multi_cond_get(void)
+	__attribute__((context(lock_a, 0, -1)))
+	__attribute__((context(lock_b, 0, 1)));
+static void release_a(void) __attribute__((context(lock_a, 1, 0)))
+{
+	__context__(lock_a, -1);
+}
+static void release_b(void) __attribute__((context(lock_b, 1, 0)))
+{
+	__context__(lock_b, -1);
+}
+static void good_multi_cond(void)
+{
+	if (multi_cond_get())
+		release_a();
+	release_b();
+}
+
+static int warn_trylock_missing(void) __attribute__((context(0, -1)))
+{
+	return 1;
+}
+
+static int warn_trylock_inverted(void) __attribute__((context(0, -1)))
+{
+	__context__(1);
+	return 0;
+}
+
+static int warn_trylock_uncond(int x) __attribute__((context(0, -1)))
+{
+	__context__(1);
+	return x;
+}
 /*
  * check-name: Check -Wcontext
  *
  * check-error-start
-context.c:69:13: warning: context imbalance in 'warn_lock1' - wrong coun=
t at exit
-context.c:74:13: warning: context imbalance in 'warn_lock2' - wrong coun=
t at exit
-context.c:81:13: warning: context imbalance in 'warn_lock3' - wrong coun=
t at exit
-context.c:88:13: warning: context imbalance in 'warn_unlock1' - unexpect=
ed unlock
-context.c:93:13: warning: context imbalance in 'warn_unlock2' - unexpect=
ed unlock
-context.c:131:12: warning: context imbalance in 'warn_if1' - wrong count=
 at exit
-context.c:140:12: warning: context imbalance in 'warn_if2' - different l=
ock contexts for basic block
-context.c:202:9: warning: context imbalance in 'warn_while1' - different=
 lock contexts for basic block
-context.c:210:17: warning: context imbalance in 'warn_while2' - unexpect=
ed unlock
-context.c:216:9: warning: context imbalance in 'warn_while3' - wrong cou=
nt at exit
-context.c:274:13: warning: context imbalance in 'warn_goto1' - wrong cou=
nt at exit
-context.c:283:13: warning: context imbalance in 'warn_goto2' - wrong cou=
nt at exit
-context.c:300:5: warning: context imbalance in 'warn_goto3' - different =
lock contexts for basic block
-context.c:315:5: warning: context imbalance in 'warn_cond_lock1' - diffe=
rent lock contexts for basic block
+context.c:34:29: warning: nonsensical conditional output context with no=
 condition
+context.c:84:13: warning: context imbalance in 'warn_lock1' - wrong coun=
t at exit
+context.c:89:13: warning: context imbalance in 'warn_lock2' - wrong coun=
t at exit
+context.c:96:13: warning: context imbalance in 'warn_lock3' - wrong coun=
t at exit
+context.c:103:13: warning: context imbalance in 'warn_unlock1' - unexpec=
ted unlock
+context.c:108:13: warning: context imbalance in 'warn_unlock2' - unexpec=
ted unlock
+context.c:146:12: warning: context imbalance in 'warn_if1' - wrong count=
 at exit
+context.c:155:12: warning: context imbalance in 'warn_if2' - different l=
ock contexts for basic block
+context.c:217:9: warning: context imbalance in 'warn_while1' - different=
 lock contexts for basic block
+context.c:225:17: warning: context imbalance in 'warn_while2' - unexpect=
ed unlock
+context.c:231:9: warning: context imbalance in 'warn_while3' - wrong cou=
nt at exit
+context.c:289:13: warning: context imbalance in 'warn_goto1' - wrong cou=
nt at exit
+context.c:298:13: warning: context imbalance in 'warn_goto2' - wrong cou=
nt at exit
+context.c:315:5: warning: context imbalance in 'warn_goto3' - different =
lock contexts for basic block
+context.c:330:5: warning: context imbalance in 'warn_cond_lock1' - diffe=
rent lock contexts for basic block
+context.c:370:12: warning: context imbalance in 'warn_trylock_missing' -=
 wrong count at exit
+context.c:375:12: warning: context imbalance in 'warn_trylock_inverted' =
- wrong count at exit
+context.c:381:12: warning: context imbalance in 'warn_trylock_uncond' - =
wrong count at exit
  * check-error-end
  */
